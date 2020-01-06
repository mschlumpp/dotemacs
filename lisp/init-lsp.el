(use-package lsp-mode
  :general
  (my-leader-def
    "mff" 'lsp-format-buffer
    "mfr" 'lsp-format-region
    "ma" 'lsp-execute-code-action)
  :config
  (add-hook 'lsp-mode-hook 'flycheck-mode-on-safe)
  (add-hook 'lsp-mode-hook 'yas-minor-mode)
  (setq lsp-prefer-flymake nil)

  (use-package lsp-ui
    :general
    (lsp-ui-mode-map
     [remap xref-find-definitions] 'lsp-ui-peek-find-definitions
     [remap xref-find-references] 'lsp-ui-peek-find-references)
    (lsp-ui-peek-mode-map
     "k" 'lsp-ui-peek--select-prev
     "j" 'lsp-ui-peek--select-next
     "h" 'lsp-ui-peek--select-prev-file
     "l" 'lsp-ui-peek--select-next-file)
    :init
    (add-hook 'lsp-mode-hook 'lsp-ui-mode)
    :config
    (setq lsp-ui-sideline-enable nil)

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
