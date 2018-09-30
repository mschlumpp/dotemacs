(req-package ivy
  :diminish ivy-mode
  :demand t
  :config
  (setq ivy-use-virtual-buffers t
        ivy-virtual-abbreviate 'full
        ivy-extra-directories nil) ;; Remove .. and .
  (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line)
  (define-key ivy-minibuffer-map (kbd "C-l") 'ivy-alt-done)
  (define-key ivy-minibuffer-map (kbd "C-h") 'ivy-backward-kill-word)
  (ivy-mode 1))

(req-package swiper
  :require ivy
  :bind (("C-s" . swiper)))

(req-package ivy-rich
  :require ivy
  :demand t
  :config
  (ivy-rich-mode))

(req-package ivy-xref
  :require ivy
  :init
  (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))

(req-package ivy-hydra
  :demand t
  :require ivy)

(req-package smex
  :demand t)

(req-package counsel
  :require (evil-leader smex)
  :diminish
  :demand t
  :config
  (counsel-mode 1)
  (evil-leader/set-key
    "h" 'counsel-fzf))

(req-package neotree
  :commands neotree-toggle
  :bind ("<f8>" . neotree-toggle)
  :config
  (setq-default neo-theme 'ascii))

(req-package avy
  :bind ("C-ö" . avy-goto-word-or-subword-1))

(provide 'init-navigation)
