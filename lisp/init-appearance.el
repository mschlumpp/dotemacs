;; Add custom theme path
(add-to-list 'custom-theme-load-path (concat user-emacs-directory (convert-standard-filename "themes/")))

;; Disable Toolbars and other ugly stuff
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-startup-screen t)

(show-paren-mode t)
(blink-cursor-mode -1)
(column-number-mode t)


;; Font
(add-to-list 'default-frame-alist
             '(font . "Input Mono Narrow:pixelsize=12"))

(setq-default show-trailing-whitespace t
              echo-keystrokes 0.5)

(use-package zerodark-theme
  :init
  (load-theme 'zerodark t))

(use-package beacon
  :ensure t
  :config
  (beacon-mode 1))

(provide 'init-appearance)
