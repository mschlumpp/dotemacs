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

;; Silence ad-handle-definition warnings
(setq ad-redefinition-action 'accept)

;; Font
(set-frame-font "Iosevka Term-11")
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

(use-package fringe-helper
  :init
  (unless (fboundp 'define-fringe-bitmap)
    (defun define-fringe-bitmap (&rest _))))

(use-package hl-todo
  :hook ((prog-mode tex-mode) . hl-todo-mode))

(use-package highlight-numbers
  :demand t
  :init
  (add-hook 'prog-mode-hook 'highlight-numbers-mode))

;; Source: https://ogbe.net/blog/toggle-serif.html
(defvar serif-preserve-default-list nil
  "A list holding the faces that preserve the default family and
  height when TOGGLE-SERIF is used.")
(setq serif-preserve-default-list
      '(;; LaTeX markup
        font-latex-math-face
        font-latex-sedate-face
        font-latex-warning-face
        ;; org markup
        org-latex-and-related
        org-meta-line
        org-verbatim
        org-block-begin-line
        ;; syntax highlighting using font-lock
        font-lock-builtin-face
        font-lock-comment-delimiter-face
        font-lock-comment-face
        font-lock-constant-face
        font-lock-doc-face
        font-lock-function-name-face
        font-lock-keyword-face
        font-lock-negation-char-face
        font-lock-preprocessor-face
        font-lock-regexp-grouping-backslash
        font-lock-regexp-grouping-construct
        font-lock-string-face
        font-lock-type-face
        font-lock-variable-name-face
        font-lock-warning-face))

(defun xy//toggle-serif ()
  "Change the default face of the current buffer to use a serif family."
  (interactive)
  (when (display-graphic-p)  ;; this is only for graphical emacs
    ;; the serif font familiy and height, save the default attributes
    (let ((serif-fam "DejaVu Sans")
          (serif-height 110)
          (default-fam (face-attribute 'default :family))
          (default-height (face-attribute 'default :height)))
      (if (not (bound-and-true-p default-cookie))
          (progn (make-local-variable 'default-cookie)
                 (make-local-variable 'preserve-default-cookies-list)
                 (setq preserve-default-cookies-list nil)
                 ;; remap default face to serif
                 (setq default-cookie
                       (face-remap-add-relative
                        'default :family serif-fam :height serif-height))
                 ;; keep previously defined monospace fonts the same
                 (dolist (face serif-preserve-default-list)
                   (add-to-list 'preserve-default-cookies-list
                                (face-remap-add-relative
                                 face :family default-fam :height default-height)))
                 (message "Turned on serif writing font."))
        ;; undo changes
        (progn (face-remap-remove-relative default-cookie)
               (dolist (cookie preserve-default-cookies-list)
                 (face-remap-remove-relative cookie))
               (setq default-cookie nil)
               (setq preserve-default-cookies-list nil)
               (message "Restored default fonts."))))))

(provide 'init-appearance)
