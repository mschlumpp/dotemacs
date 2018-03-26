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

(defun xy//remove-bold ()
  (interactive)
  (mapc
   (lambda (face)
     (set-face-attribute face nil :weight 'normal :underline nil))
   (face-list)))

(setq-default show-trailing-whitespace t
              echo-keystrokes 0.5)

(req-package beacon
  :diminish beacon-mode
  :config
  (beacon-mode 1))

(req-package spaceline
  :config
  (require 'spaceline-config)
  (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
  (spaceline-spacemacs-theme))

(req-package fringe-helper
  :commands fringe-helper-define
  :init
  (unless (fboundp 'define-fringe-bitmap)
    (defun define-fringe-bitmap (&rest _))))

(provide 'init-appearance)
