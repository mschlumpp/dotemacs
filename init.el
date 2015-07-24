;; init.el --- The new config file

;;;; Put Customize stuff into separate file
(setq custom-file (concat user-emacs-directory (convert-standard-filename "custom.el")))
(load custom-file)

;;;; Appearance
;; Theme
(add-to-list 'custom-theme-load-path (concat user-emacs-directory (convert-standard-filename "themes/")))
(load-theme 'ujelly t)
(setq sml/theme 'dark)

;; Disable Toolbars and other ugly stuff
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-startup-screen t)

;; Font
(add-to-list 'default-frame-alist
             '(font . "terminus:pixelsize=9"))

(setq-default show-trailing-whitespace t
              indent-tabs-mode nil
              echo-keystrokes 0.5)

;;;; General settings
;; Increase GC Threshold
(setq gc-cons-threshold 20000000)
;; Fix scrolling
(setq mouse-wheel-scroll-amount '(5)
      mouse-wheel-progressive-speed nil)
;; Truncate long lines
(toggle-truncate-lines 1)

;; Backup files
(setq backup-directory-alist `(("." . "~/.saves"))
      delete-old-versions t
      kept-old-versions 2
      kept-new-versions 4
      version-control t)

;;; Modes
(show-paren-mode t)
(column-number-mode t)
(blink-cursor-mode -1)
(delete-selection-mode t)
(electric-pair-mode t)
(windmove-default-keybindings)

;; Uniquify buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Some keybindings
(global-set-key (kbd "C-c o") 'ff-find-other-file)

;; Org mode
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c g") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)

(setq org-directory "~/org"
      org-default-notes-file (concat org-directory "/notes.org")
      org-refile-targets
      '((org-agenda-files :maxlevel . 2))
      org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/notes.org" "Tasks")
         "* TODO %?\n  %i\n  %a")))

;;;; Package management
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa")
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

;; Make sure use-package is installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)

;;;; Macros
(defmacro after (mode &rest body)
  "`eval-after-load' MODE evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,mode
     '(progn ,@body)))

;;;; Paredit
(defun use-paredit ()
  (electric-pair-mode -1)
  (paredit-mode 1))

;;;; Magit
(use-package magit
  :commands magit-status
  :bind ("C-c i" . magit-status)
  :config
  (setq magit-last-seen-setup-instructions "1.4.0"))

;;;; Anzu
(use-package anzu
  :ensure t
  :demand t
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp))
  :config
  (global-anzu-mode 1))

;;;; Expand region
(use-package expand-region
  :ensure t
  :commands er/expand-region
  :bind ("C-+" . er/expand-region))

;;;; Projectile
(use-package projectile
  :ensure t
  :bind ("C-c h" . projectile-find-file)
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (setq projectile-completion-system 'default)
  (projectile-global-mode 1))

;;;; rtags
(use-package rtags
  :commands (rtags-find-symbol-at-point rtags-location-stack-back)
  :bind (("C-c r ," . rtags-find-references-at-point)
         ("C-c r v" . rtags-find-virtuals-at-point)
         ("C-c r h" . rtags-print-class-hierarchy)
         ("C-c r f" . rtags-fixit)
         ("C-c r r" . rtags-rename-symbol)
         ("C-M-8" . rtags-previous-match)
         ("C-M-9" . rtags-next-match))
  :init
  (add-hook 'c-mode-common-hook (lambda ()
                                 (define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
                                 (define-key c-mode-base-map (kbd "M-,") 'rtags-location-stack-back))))

;;;; Company
(use-package company
  :ensure t
  :config
  (global-company-mode 1))

;;;; Irony
(use-package irony
  :commands irony-mode
  :init
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package company-irony
  :commands company-irony
  :init
  (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
  :config
  (add-to-list 'company-backends 'company-irony))

(use-package irony-eldoc
  :commands irony-eldoc
  :init
  (add-hook 'irony-mode-hook 'irony-eldoc))

(use-package flycheck-irony
  :commands flycheck-irony-setup
  :init
  (add-hook 'irony-mode-hook 'flycheck-irony-setup)
  (add-hook 'irony-mode-hook 'flycheck-mode-on-safe))

;;;; Load compile flags from CMake
(use-package cpputils-cmake
  :commands cppcm-reload-all
  :init
  (add-hook 'c-mode-common-hook (lambda ()
                                  (if (derived-mode-p 'c-mode 'c++-mode)
                                      (cppcm-reload-all))))
  :config
  (setq cppcm-write-flymake-makefile nil))

;;;; Flycheck
(use-package flycheck
  :commands flycheck-mode-on-safe)

;;;; SLIME
(use-package slime
  :commands slime
  :init
  (add-hook 'slime-mode-hook 'use-paredit)
  (add-hook 'slime-repl-mode-hook 'use-paredit)
  :config
  (slime-setup '(slime-company slime-fancy))
  (setq inferior-lisp-program "/usr/bin/sbcl"))

;;;; Whitespace cleanup mode
(use-package whitespace-cleanup-mode
  :config
  (global-whitespace-cleanup-mode 1))

;;;; c-mode setup
(after "cc-mode"
  (c-add-style "unknown"
               '("java"
                 (c-offsets-alist
                  (innamespace . 0)
                  (access-label . -4)
                  (inclass . 4))))
  (setq c-default-style "unknown"
        indent-tabs-mode 0
        c-basic-offset 4
        c-cleanup-list '(defun-close-semi
                          scope-operator
                          empty-defun-braces)))

;;;; Helm
(use-package helm
  :demand t
  :bind (("M-x" . helm-M-x)
         ("C-c m" . helm-mini)
         ("C-c a" . helm-do-ag))
  :config
  (require 'helm-config)
  (helm-mode 1))

;;;; fic mode (FIXME, TODO and BUG highlighting
(use-package fic-mode
  :commands turn-on-fic-mode
  :init
  (add-hook 'c++-mode-hook 'turn-on-fic-mode))

;;;; Neo Tree
(use-package neotree
  :commands neotree-toggle
  :bind ("<f8>" . neotree-toggle)
  :config
  (setq-default neo-theme 'ascii))

;;;; Smart mode line
(use-package smart-mode-line
  :config
  (setq sml/no-confirm-load-theme t)
  (sml/setup))

;;;; gdb
(setq gdb-many-windows t)

;;;; Guide-key
(use-package guide-key
  :config
  (setq guide-key/recursive-key-sequence-flag t
        guide-key/guide-key-sequence '("C-x c" "C-c" "C-x 4")
        guide-key/highlight-command-regexp
        '("rectangle"
          ("at-point" . "Royalblue3")))
  (guide-key-mode 1))

;;;; Undo-tree
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1))

;;;; Popwin
(use-package popwin
  :demand t
  :defines popwin:keymap
  :config
  (popwin-mode)
  (global-set-key (kbd "C-c w") popwin:keymap)
  (add-to-list 'popwin:special-display-config '("*RTags*" :noselect t :position right :width 60)))

;;;; Python
(use-package jedi
  :commands jedi:setup
  :init
  (add-hook 'python-mode-hook 'jedi:setup))

(use-package alchemist
  :commands alchemist-mode
  :config
  (setq alchemist-key-command-prefix (kbd "C-c f")))
