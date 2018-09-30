(req-package lsp-mode
  :config
  (add-hook 'lsp-mode-hook 'flycheck-mode-on-safe)
  (add-hook 'lsp-mode-hook 'yas-minor-mode)
  (evil-leader/set-key
    "mff" 'lsp-format-buffer
    "mfr" 'lsp-format-region
    "ma" 'lsp-execute-code-action))

(req-package lsp-ui
  :require lsp-mode
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (define-key lsp-ui-peek-mode-map (kbd "k") #'lsp-ui-peek--select-prev)
  (define-key lsp-ui-peek-mode-map (kbd "j") #'lsp-ui-peek--select-next)
  (define-key lsp-ui-peek-mode-map (kbd "h") #'lsp-ui-peek--select-prev-file)
  (define-key lsp-ui-peek-mode-map (kbd "l") #'lsp-ui-peek--select-next-file)
  (setq lsp-ui-sideline-show-hover nil))

(req-package company-lsp
  :require lsp-mode
  :demand t
  :init
  (push 'company-lsp company-backends))

(provide 'init-lsp)
