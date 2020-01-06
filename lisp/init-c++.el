(use-package cc-mode
  :config
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

(setq compilation-scroll-output 'first-error)

(defun xy//setup-cquery ()
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

;; (use-package ccls
;;   :demand t
;;   :hook ((c-mode c++-mode) . xy//setup-cquery)
;;   :config
;;   (add-to-list 'evil-emacs-state-modes 'ccls-tree-mode)
;;   (setq ccls-sem-highlight-method 'font-lock)
;;   (ccls-use-default-rainbow-sem-highlight))

(defun xy//enable-ccls ()
  (interactive)
  (mapc (lambda (buf) (with-current-buffer buf
                        (when (derived-mode-p 'c-mode)
                          (lsp))))
        (projectile-project-buffers))
  (add-hook 'c-mode-hook 'lsp)
  (add-hook 'c++-mode-hook 'lsp))

;;;; gdb
(setq gdb-many-windows t)

(provide 'init-c++)
