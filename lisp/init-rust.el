;;;; Rust
(req-package rust-mode)

(req-package racer
  :require (flycheck rust-mode)
  :commands (racer-mode)
  :init
  (add-hook 'rust-mode-hook #'(lambda ()
                                (racer-mode 1)
                                (eldoc-mode 1)
                                (flycheck-mode 1)
                                (local-set-key (kbd "M-.") #'racer-find-definition)
                                (local-set-key (kbd "TAB") #'company-indent-or-complete-common))))

(req-package cargo
  :require rust-mode
  :init
  (evil-leader/set-key
    "mt" 'cargo-process-test
    "mm" 'cargo-process-check
    "mb" 'cargo-process-build
    "mr" 'cargo-process-run))

(provide 'init-rust)
