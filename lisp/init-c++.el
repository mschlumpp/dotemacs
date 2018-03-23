(after "cc-mode"
  (add-hook 'c++-mode-hook (lambda () (subword-mode 1)))
  (c-add-style "unknown"
	       '("java"
		 (c-offsets-alist
		  (topmost-intro-cont . 0)
		  (access-label . -)
		  (inclass . +))))
  (setq c-default-style "unknown"
	indent-tabs-mode 0
	c-basic-offset 4
	c-cleanup-list '(defun-close-semi
			  scope-operator
			  empty-defun-braces))

  (defadvice c-lineup-arglist (around lambda-lineup activate)
    "Improve indentation of continued C++11 lambda function opened as argument."
    (setq ad-return-value
	  (if (and (equal major-mode 'c++-mode)
		   (ignore-errors
		     (save-excursion
		       (goto-char (c-langelem-pos langelem))
		       ;; Detect "[...](" or "[...]{". preceded by "," or "(",
		       ;;   and with unclosed brace.
		       (looking-at ".*[(,][ \t]*\\[[^]]*\\][ \t]*[({][^}]*$"))))
	      0                           ; no additional indent
	    ad-do-it))))

(req-package fic-mode
  :commands (turn-on-fic-mode)
  :init
  (add-hook 'c++-mode-hook 'fic-mode))

(req-package cpputils-cmake
  :commands cppcm-reload-all
  :init
  (add-hook 'c-mode-common-hook (lambda ()
				  (if (derived-mode-p 'c-mode 'c++-mode)
				      (cppcm-reload-all))))
  :config
  (setq cppcm-write-flymake-makefile nil))

(req-package cquery
  :require lsp-mode lsp-ui hydra
  :commands (lsp-cquery-enable)
  :init
  (add-hook 'c-mode-hook 'lsp-cquery-enable)
  (add-hook 'c++-mode-hook 'lsp-cquery-enable)
  (defun xy//cquery-find-base ()
    (interactive)
    (lsp-ui-peek-find-custom 'base "$cquery/base"))
  (defun xy//cquery-find-callers ()
    (interactive)
    (lsp-ui-peek-find-custom 'callers "$cquery/callers"))
  (defun xy//cquery-find-vars ()
    (interactive)
    (lsp-ui-peek-find-custom 'vars "$cquery/vars"))
  (defun xy//cquery-find-derived ()
    (interactive)
    (lsp-ui-peek-find-custom 'derived "$cquery/derived"))
  (evil-leader/set-key-for-mode 'c++-mode
    "n b" 'xy//cquery-find-base
    "n c" 'xy//cquery-find-callers
    "n v" 'xy//cquery-find-vars
    "n d" 'xy//cquery-find-derived)
  :config
  (add-to-list 'evil-emacs-state-modes 'cquery-tree-mode)

  (setq company-transformers nil
        company-lsp-async t
        company-lsp-cache-candidates nil)
  (setq cquery-extra-init-params '(:index (:comments 2) :cacheFormat "msgpack"))
  (setq cquery-sem-highlight-method 'overlay)
  (cquery-use-default-rainbow-sem-highlight)
  (add-to-list 'cquery--handlers '("$cquery/progress" .
                                   (lambda (w p)
                                     (let* ((indexRequestCount (gethash "indexRequestCount" p))
                                            (doIdMapCount (gethash "doIdMapCount" p))
                                            (loadPreviousIndexCount (gethash "loadPreviousIndexCount" p))
                                            (onIdMappedCount (gethash "onIdMappedCount" p))
                                            (onIndexedCount (gethash "onIndexedCount" p))
                                            (activeThreads (gethash "activeThreads" p))
                                            (total (+ indexRequestCount
                                                      doIdMapCount
                                                      loadPreviousIndexCount
                                                      onIdMappedCount
                                                      onIndexedCount
                                                      activeThreads)))
                                       (if (eql total 0)
                                           (setq lsp-status "(idle)")
                                         (setq lsp-status (format "(%d/%d jobs)" activeThreads total)))))) t))

;;;; clang-format
(req-package clang-format
  :init
  (evil-leader/set-key
    "mff" 'clang-format-buffer
    "mfr" 'clang-format-region))

;;;; gdb
(setq gdb-many-windows t)

(provide 'init-c++)
