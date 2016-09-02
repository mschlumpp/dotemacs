;;;; Rust
(use-package racer
  :diminish "ⓡ"
  :init
  (add-hook 'rust-mode-hook #'(lambda ()
                                ;; Disable ycmd because it doesn't work with racer...
                                (ycmd-mode -1)
                                (racer-mode 1)
                                (eldoc-mode 1)
                                (local-set-key (kbd "M-.") #'racer-find-definition)
                                (local-set-key (kbd "TAB") #'company-indent-or-complete-common))))

(provide 'init-rust)
