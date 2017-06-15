;;;; Rust
(req-package rust-mode)

(req-package racer
  :require rust-mode
  :diminish "ⓡ"
  :init
  (add-hook 'rust-mode-hook #'(lambda ()
                                ;; Disable ycmd because it doesn't work with racer...
                                (when (fboundp 'ycmd-mode)
                                  (ycmd-mode -1))
                                (racer-mode 1)
                                (eldoc-mode 1)
                                (when (fboundp 'flycheck-mode)
                                  (flycheck-mode 1))
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
