;; init.el --- The new config file

;;;; Appearance
;; Disable Toolbars and other ugly stuff
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-startup-screen t)

;; Font
(add-to-list 'default-frame-alist
	     '(font . "Terminusmodx.Icons:pixelsize=9"))

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
  :bind ("<f8>" . neotree-toggle))

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

;;;; Python
(use-package jedi
  :commands jedi:setup
  :init
  (add-hook 'python-mode-hook 'jedi:setup))

(use-package alchemist
  :commands alchemist-mode
  :config
  (setq alchemist-key-command-prefix (kbd "C-c f")))

(use-package cpputils-cmake
  :commands cppcm-reload-all
  :init
  (add-hook 'c-mode-common-hook (lambda ()
                                  (if (derived-mode-p 'c-mode 'c++-mode)
                                      (cppcm-reload-all))))
  :config
  (setq cppcm-write-flymake-makefile nil))

;; Customize variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Linum-format "%7i ")
 '(ansi-color-names-vector
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#839496"])
 '(background-color "#202020")
 '(background-mode dark)
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(compilation-message-face (quote default))
 '(cursor-color "#cccccc")
 '(custom-safe-themes
   (quote
    ("7a778124fe4474197006e6131acead2b32acc8dd06be7c70a1b2a5f0fec5f0ee" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "c3b79a6eed3dac3e86f48d06f61c3fd1c7d73b647af0ddaf36a673c006f1a8eb" "255104c2f5c857498231bc7efbd374026e4ad43547d6fdb4c08be95bc9c871bd" "c5a044ba03d43a725bd79700087dea813abcb6beb6be08c7eb3303ed90782482" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" "7bf64a1839bf4dbc61395bd034c21204f652185d17084761a648251041b70233" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "ef43b291f7e96826d3d9bae61434a93020d0f529d609bc8be5b331980e8448d7" default)))
 '(diary-entry-marker (quote font-lock-variable-name-face))
 '(fci-rule-character-color "#202020")
 '(fci-rule-color "#202020")
 '(flycheck-disabled-checkers (quote (c/c++-clang c/c++-gcc)))
 '(foreground-color "#cccccc")
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(indicate-empty-lines t)
 '(ivy-mode t)
 '(linum-format " %5i ")
 '(magit-diff-use-overlays nil)
 '(magit-log-arguments (quote ("--graph" "--color" "--decorate")))
 '(magit-use-overlays nil)
 '(org-agenda-files (quote ("~/org/notes.org")))
 '(package-selected-packages
   (quote
    (anzu expand-region noctilux-theme jedi esup use-package hungry-delete rtags company-go go-mode eval-sexp-fu slime-company company-c-headers smartparens elm-mode flycheck-rust rust-mode zerodark-theme cpputils-cmake bison-mode helm-ag projectile web-mode elixir-mode alchemist adoc-mode virtualenvwrapper pyvenv geiser css-eldoc sql-indent goto-chg paredit undo-tree rainbow-blocks rainbow-delimiters stgit magit-stgit ample-theme guide-key ace-jump-mode helm-themes rnc-mode yasnippet yaml-mode ujelly-theme tup-mode toml-mode sublime-themes stekene-theme spacegray-theme soothe-theme solarized-theme soft-charcoal-theme smart-mode-line scion plantuml-mode planet-theme noflet neotree markdown-mode+ lua-mode latex-preview-pane key-chord json-mode irony-eldoc highlight-indentation hamlet-mode grizzl git-gutter-fringe+ fuzzy flycheck-irony flx-ido fic-mode cyberpunk-theme company-irony color-theme-sanityinc-tomorrow cmake-mode auctex ag)))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(rng-schema-locating-files
   (quote
    ("schemas.xml" "/usr/share/emacs/25.0.50/etc/schema/schemas.xml" "/home/marco/.schema/schemas.xml")))
 '(rtags-path "/home/marco/src/rtags/build/")
 '(show-paren-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
