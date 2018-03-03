(req-package lsp-mode)

(req-package lsp-ui
  :require lsp-mode
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (setq lsp-ui-sideline-show-hover nil))

(req-package company-lsp
  :require lsp-mode
  :init
  (push 'company-lsp company-backends)
  :config
  (setq company-lsp-async t))

(provide 'init-lsp)
