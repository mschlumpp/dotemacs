(use-package swiper
  :demand t
  :config
  (setq ivy-display-style 'fancy)
  (ivy-mode 1))

(use-package counsel
  :demand t
  :bind (("M-x" . counsel-M-x)
         ("C-c a" . counsel-ag)))

(use-package neotree
  :commands neotree-toggle
  :bind ("<f8>" . neotree-toggle)
  :config
  (setq-default neo-theme 'ascii))

(use-package avy
  :bind ("C-ö" . avy-goto-word-or-subword-1))

(provide 'init-navigation)
