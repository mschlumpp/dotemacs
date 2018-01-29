;;;; Rust
(req-package rust-mode
  :commands (rust-mode))

(req-package lsp-rust
  :require rust-mode lsp-mode
  :init
  (add-hook 'rust-mode-hook #'lsp-rust-enable)
  :config
  (setq lsp-rust-rls-command '("rustup" "run" "nightly" "rls")))

(req-package cargo
  :require rust-mode
  :init
  (evil-leader/set-key
    "mt" 'cargo-process-test
    "mm" 'cargo-process-check
    "mb" 'cargo-process-build
    "mr" 'cargo-process-run))

(provide 'init-rust)
