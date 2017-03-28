(use-package swiper
  :diminish ivy-mode
  :demand t
  :ensure t
  :bind (("C-s" . swiper))
  :config
  (setq ivy-use-virtual-buffers t)
  (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line)
  (define-key ivy-minibuffer-map (kbd "C-l") 'ivy-alt-done)
  (define-key ivy-minibuffer-map (kbd "C-h") 'ivy-backward-kill-word)
  (ivy-mode 1))

(use-package counsel
  :ensure t
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
