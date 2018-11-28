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

(defun xy//setup-cquery ()
  (lsp-cquery-enable)
  (setq-local company-transformers nil)
  (setq-local company-lsp-async t)
  (setq-local company-lsp-cache-candidates nil))

(defun xy//cquery-find-base ()
  (interactive)
  (lsp-ui-peek-find-custom 'base "$cquery/base"))

(defun xy//cquery-find-callers ()
  (interactive)
  (lsp-ui-peek-find-custom 'callers "$cquery/callers"))

(defun xy//cquery-find-vars ()
  (interactive)
  (lsp-ui-peek-find-custom 'vars "$cquery/vars"))

(req-package cquery
  :commands (lsp-cquery-enable)
  :hook ((c-mode c++-mode) . xy//setup-cquery)
  :init
  (add-hook 'c-mode-hook #'xy//setup-cquery)
  (add-hook 'c++-mode-hook #'xy//setup-cquery)
  (evil-leader/set-key-for-mode 'c++-mode
    "n b" 'xy//cquery-find-base
    "n c" 'xy//cquery-find-callers
    "n v" 'xy//cquery-find-vars)

  :config
  (add-to-list 'evil-emacs-state-modes 'cquery-tree-mode)

  (setq cquery-extra-init-params '(:index (:comments 2) :completion (:detailedLabel t) :cacheFormat "msgpack"))
  (setq cquery-sem-highlight-method 'overlay)
  (cquery-use-default-rainbow-sem-highlight))

;;;; gdb
(setq gdb-many-windows t)

(provide 'init-c++)
