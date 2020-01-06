;;;; Rust
(use-package rust-mode
  :mode "\\.rs\\'"
  :commands (rust-mode)
  :hook (rust-mode . auto-revert-mode)
  :config
  (use-package cargo
    :general
    (my-leader-def rust-mode-map
      "mt" 'cargo-process-test
      "mc" 'cargo-process-current-file-tests
      "mC" 'cargo-process-current-test

      "mm" 'cargo-process-check
      "mb" 'cargo-process-build
      "ml" 'cargo-process-clippy

      "md" 'cargo-process-doc
      "mD" 'cargo-process-doc-open

      "mr" 'cargo-process-run)))


(provide 'init-rust)
