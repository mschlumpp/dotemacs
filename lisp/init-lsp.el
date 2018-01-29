(req-package lsp-mode)

(req-package company-lsp
  :require lsp-mode
  :init
  (push 'company-lsp company-backends)
  :config
  (setq company-lsp-async t))

(provide 'init-lsp)
