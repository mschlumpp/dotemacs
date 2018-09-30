;; Disable Toolbars and other ugly stuff
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-startup-screen t)

(show-paren-mode t)
(blink-cursor-mode -1)
(column-number-mode t)
(global-hl-line-mode t)

;; Set frames by default maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Font
(add-to-list 'default-frame-alist
             '(font . "Iosevka Term-11"))
(setq x-underline-at-descent-line t)

(defun xy//remove-bold ()
  (interactive)
  (mapc
   (lambda (face)
     (set-face-attribute face nil :weight 'normal :underline nil))
   (face-list)))

(setq-default echo-keystrokes 0.5)

(defun xy//show-trailing-whitespace ()
  (setq-local show-trailing-whitespace t))

(add-hook 'prog-mode-hook 'xy//show-trailing-whitespace)
(add-hook 'conf-mode-hook 'xy//show-trailing-whitespace)

(req-package beacon
  :diminish beacon-mode
  :demand t
  :config
  (beacon-mode 1))

(req-package fringe-helper
  :init
  (unless (fboundp 'define-fringe-bitmap)
    (defun define-fringe-bitmap (&rest _))))

(provide 'init-appearance)
