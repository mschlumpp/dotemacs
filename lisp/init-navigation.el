(use-package ivy
  :diminish ivy-mode
  :demand t
  :general
  (ivy-minibuffer-map
   "C-j" 'ivy-next-line
   "C-k" 'ivy-previous-line
   "C-l" 'ivy-alt-done
   "C-h" 'ivy-backward-kill-word)
  (my-leader-def
    "r" 'ivy-resume)
  :config
  (setq ivy-use-virtual-buffers t
        ivy-virtual-abbreviate 'full
        ivy-extra-directories nil) ;; Remove .. and .
  (setq ivy-re-builders-alist
        '((swiper     . ivy--regex-plus)
          (counsel-ag . ivy--regex-plus)
          (counsel-rg . ivy--regex-plus)
          (t          . ivy--regex-fuzzy)))
  (ivy-mode 1)
  (evil-set-initial-state 'ivy-occur-grep-mode 'normal)
  (evil-make-overriding-map ivy-occur-mode-map 'normal))

(use-package counsel
  :diminish
  :general
  ("C-s" 'counsel-grep-or-swiper)
  (my-leader-def
    "h" 'counsel-fzf
    "fr" 'counsel-recentf)
  :demand t
  :config
  (counsel-mode 1)
  (when (executable-find "fd")
    (setenv "FZF_DEFAULT_COMMAND" "fd --type f")))

(use-package swiper
  :demand t)

(use-package ivy-rich
  :demand t
  :config
  (ivy-rich-mode 1))

(use-package ivy-xref
  :init
  (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))

(use-package ivy-hydra
  :demand t)

(use-package smex
  :demand t)

(use-package avy
  :general
  ("M-[" 'avy-goto-word-or-subword-1))

(provide 'init-navigation)
