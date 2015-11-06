;;;; Rust
(use-package racer
  :init
  (add-hook 'rust-mode-hook #'(lambda ()
                                (racer-activate)
                                (racer-turn-on-eldoc)
                                (local-set-key (kbd "M-.") #'racer-find-definition)
                                (local-set-key (kbd "TAB") #'racer-complete-or-indent))))


(provide 'init-rust)
