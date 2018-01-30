(req-package swiper
  :diminish ivy-mode
  :demand t
  :bind (("C-s" . swiper))
  :config
  (setq ivy-use-virtual-buffers t)
  (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line)
  (define-key ivy-minibuffer-map (kbd "C-l") 'ivy-alt-done)
  (define-key ivy-minibuffer-map (kbd "C-h") 'ivy-backward-kill-word)
  (ivy-mode 1))

(req-package ivy-xref
  :require swiper
  :commands ivy-xref-show-xrefs
  :init
  (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))

(req-package ivy-hydra
  :require swiper)

(req-package counsel
  :require evil-leader
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
