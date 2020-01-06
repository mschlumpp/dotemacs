(use-package lsp-mode
  :config
  (add-hook 'lsp-mode-hook 'flycheck-mode-on-safe)
  (add-hook 'lsp-mode-hook 'yas-minor-mode)
  (setq lsp-prefer-flymake nil)
  (evil-leader/set-key
    "mff" 'lsp-format-buffer
    "mfr" 'lsp-format-region
    "ma" 'lsp-execute-code-action)

  (use-package lsp-ui
    :init
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)
    :config
    (setq lsp-ui-sideline-enable nil)
    (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
    (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
    (define-key lsp-ui-peek-mode-map (kbd "k") #'lsp-ui-peek--select-prev)
    (define-key lsp-ui-peek-mode-map (kbd "j") #'lsp-ui-peek--select-next)
    (define-key lsp-ui-peek-mode-map (kbd "h") #'lsp-ui-peek--select-prev-file)
    (define-key lsp-ui-peek-mode-map (kbd "l") #'lsp-ui-peek--select-next-file)

    (require 'lsp-ui-flycheck)
    (add-hook 'lsp-after-open-hook (lambda () (lsp-ui-flycheck-enable 1))))

  (use-package company-lsp
    ;; :demand t
    :init
    (push 'company-lsp company-backends)))

(defun xy//lsp-auto-enable ()
  (interactive)
  (add-hook 'rust-mode-hook 'lsp)
  (add-hook 'c++-mode-hook 'lsp))


(provide 'init-lsp)
