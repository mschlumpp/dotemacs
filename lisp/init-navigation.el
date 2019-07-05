(req-package ivy
  :diminish ivy-mode
  :demand t
  :config
  (setq ivy-use-virtual-buffers t
        ivy-virtual-abbreviate 'full
        ivy-extra-directories nil) ;; Remove .. and .
  (setq ivy-re-builders-alist
        '((swiper     . ivy--regex-plus)
          (counsel-ag . ivy--regex-plus)
          (counsel-rg . ivy--regex-plus)
          (t          . ivy--regex-fuzzy)))
  (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line)
  (define-key ivy-minibuffer-map (kbd "C-l") 'ivy-alt-done)
  (define-key ivy-minibuffer-map (kbd "C-h") 'ivy-backward-kill-word)
  (ivy-mode 1)
  (evil-set-initial-state 'ivy-occur-grep-mode 'normal)
  (evil-make-overriding-map ivy-occur-mode-map 'normal))

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
  (when (executable-find "fd")
    (setenv "FZF_DEFAULT_COMMAND" "fd --type f"))
  (evil-leader/set-key
    "h" 'counsel-fzf
    "fr" 'counsel-recentf))

(req-package neotree
  :commands neotree-toggle
  :bind ("<f8>" . neotree-toggle)
  :config
  (setq-default neo-theme 'ascii))

(req-package avy
  :bind ("M-[" . avy-goto-word-or-subword-1))

(provide 'init-navigation)
