(after "cc-mode"
  (add-hook 'c++-mode-hook (lambda () (subword-mode 1)))
  (c-add-style "unknown"
	       '("java"
		 (c-offsets-alist
		  (topmost-intro-cont . 0)
		  (access-label . -)
                  (inlambda . 0)
		  (inclass . +))))
  (setq c-default-style "unknown"
	indent-tabs-mode 0
	c-basic-offset 4
	c-cleanup-list '(defun-close-semi
			  scope-operator
			  empty-defun-braces)))

(req-package cpputils-cmake
  :commands cppcm-reload-all
  :init
  (add-hook 'c-mode-common-hook (lambda ()
				  (if (derived-mode-p 'c-mode 'c++-mode)
				      (cppcm-reload-all))))
  :config
  (setq cppcm-write-flymake-makefile nil))

(defun xy//setup-ccls ()
  (lsp-ccls-enable)
  (setq-local company-transformers nil)
  (setq-local company-lsp-async t)
  (setq-local company-lsp-cache-candidates nil))

(req-package ccls
  :demand t
  :init
  (add-hook 'c-mode-hook #'xy//setup-ccls)
  (add-hook 'c++-mode-hook #'xy//setup-ccls)
  :config
  (add-to-list 'evil-emacs-state-modes 'ccls-tree-mode)
  (setq ccls-extra-init-params '(:cacheDirectory "/tmp/ccls" :index (:comments 2) :completion (:detailedLabel t)))
  (ccls-use-default-rainbow-sem-highlight))

;;;; gdb
(setq gdb-many-windows t)

(provide 'init-c++)
