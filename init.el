;; init.el --- The new config file

;; Customize variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Linum-format "%7i ")
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("255104c2f5c857498231bc7efbd374026e4ad43547d6fdb4c08be95bc9c871bd" "c5a044ba03d43a725bd79700087dea813abcb6beb6be08c7eb3303ed90782482" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" "7bf64a1839bf4dbc61395bd034c21204f652185d17084761a648251041b70233" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "ef43b291f7e96826d3d9bae61434a93020d0f529d609bc8be5b331980e8448d7" default)))
 '(fci-rule-character-color "#202020")
 '(fci-rule-color "#202020")
 '(fringe-mode 4 nil (fringe))
 '(linum-format " %5i ")
 '(main-line-color1 "#1E1E1E")
 '(main-line-color2 "#111111")
 '(main-line-separator-style (quote chamfer))
 '(menu-bar-mode nil)
 '(powerline-color1 "#1E1E1E")
 '(powerline-color2 "#111111")
 '(rainbow-identifiers-cie-l*a*b*-lightness 80)
 '(rainbow-identifiers-cie-l*a*b*-saturation 18)
 '(rtags-completions-enabled t)
 '(rtags-path "/home/marco/src/rtags/build/")
 '(show-paren-mode t)
 '(tool-bar-mode nil))

;;; Disable Toolbars and other ugly stuff
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-startup-screen t)

;;; Font
(add-to-list 'default-frame-alist
	     '(font . "Source Code Pro Medium:pixelsize=12"))

;;; General settings
;; Increase GC Threshold
(setq gc-cons-threshold 20000000)
;; Fix scrolling
(setq mouse-wheel-scroll-amount '(5)
      mouse-wheel-progressive-speed nil)
;; Don't blink
(blink-cursor-mode -1)
;; Column numbers
(column-number-mode t)
;; Truncate long lines
(toggle-truncate-lines 1)

(delete-selection-mode t)

(setq-default show-trailing-whitespace t
	      indent-tabs-mode nil
	      echo-keystrokes 0.5)

;; Backup files
(setq backup-directory-alist `(("." . "~/.saves"))
      delete-old-versions t
      kept-old-versions 2
      kept-new-versions 4
      version-control t)

;; Uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;; Modes
(show-paren-mode t)

;;; Some keybindings
(global-set-key (kbd "C-c o") 'ff-find-other-file)

;;;; Package managment
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa")
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(defun mp-install-rad-packages ()
  (interactive)
  (package-refresh-contents)
  (mapc #'(lambda (package)
            (unless (package-installed-p package)
              (package-install package)))
	'(ido-ubiquitous
	  magit
	  lispy
	  smex
	  evil
	  undo-tree
	  grizzl
	  projectile
	  flx
	  flx-ido
          auto-complete
          powerline)))

(defun mp-install-extra-packages ()
  (interactive)
  (mp-install-rad-packages)
  (mapc #'(lambda (package)
	    (unless (package-installed-p package)
	      (package-install package)))
	'(web-mode)))

;;;; Macros
(defmacro after (mode &rest body)
  "`eval-after-load' MODE evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,mode
     '(progn ,@body)))

;;;; Evil
(after "evil-autoloads"
  (evil-mode 1)
  (defun xy-save-buffers ()
    (interactive)
    (evil-write-all nil))
  (define-key evil-normal-state-map "UU" 'xy-save-buffers)
  (define-key evil-normal-state-map "UZ" 'save-some-buffers))

;;;; IDO/smex
;; (after "smex-autoloads"
;;   (smex-initialize)
;;   (global-set-key (kbd "M-x") 'smex)
;;   (global-set-key (kbd "M-X") 'smex-major-mode-commands)
;;   (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command))

;; (after "ido-ubiquitous-autoloads"
;;   (require 'ido-ubiquitous)
;;   (ido-mode t)
;;   (ido-ubiquitous-mode t))

;; (after "flx-ido-autoloads"
;;   (flx-ido-mode t)
;;   (setq ido-use-faces nil))

;;;; sublime-themes
;; (after "sublime-themes-autoloads"
;;   (load-theme 'granger))

(load-theme 'deep-thought)

;;;; Lispy
(after "lispy-autoloads"
  (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1))))

;;;; Magit
(after "magit-autoloads"
  (global-set-key (kbd "C-c i") 'magit-status))

;;;; Projectile
(after "projectile-autoloads"
  (projectile-global-mode 1)
  (global-set-key (kbd "C-c h") 'projectile-find-file)
  (setq projectile-completion-system 'grizzl
	projectile-show-paths-function 'projectile-hashify-with-relative-paths))

;;;; AC
(after "auto-complete-autoloads"
  (require 'auto-complete-config)
  (ac-config-default)
  (setq ac-use-menu-map t
        ac-use-fuzzy t)
  (ac-set-trigger-key "TAB")
  (define-key ac-menu-map "\C-n" 'ac-next)
  (define-key ac-menu-map "\C-p" 'ac-previous)
  (global-auto-complete-mode t))

;;;; rtags
(after "rtags-autoloads"
  (require 'rtags)
  (require 'rtags-ac)

  (rtags-enable-standard-keybindings c-mode-base-map)
  ;; Custom key bindings
  (define-key c-mode-base-map (kbd "C-ö") 'rtags-find-symbol-at-point)
  (define-key c-mode-base-map (kbd "C-8") 'rtags-location-stack-back)
  (define-key c-mode-base-map (kbd "C-9") 'rtags-location-stack-forward)
  (define-key c-mode-base-map (kbd "C-M-8") 'rtags-previous-match)
  (define-key c-mode-base-map (kbd "C-M-9") 'rtags-next-match)
  (add-hook 'c-mode-common-hook (lambda ()
				  (rtags-diagnostics)
                                  (setq ac-sources '(ac-source-rtags)))))

;;;; LanguageTool
(after "langtool-autoloads"
  (require 'langtool)
  (setq langtool-language-tool-jar "/home/marco/Downloads/LanguageTool-2.5/languagetool.jar"))

;;;; Slime from quicklisp
(when (load (expand-file-name "~/quicklisp/slime-helper.el") t t)
  (setq inferior-lisp-program "/usr/bin/sbcl"))

;;;; c-mode setup
(after "cc-mode"
  (c-add-style "unknown"
	       '("java"
		 (c-offset-alist
		  (innamespace 0)
		  (access-label -4)
		  (inclass 4))))
  (setq c-default-style "unknown"
	indent-tabs-mode 0
	c-basic-offset 4
	c-cleanup-list '(defun-close-semi
			  scope-operator
			  empty-defun-braces)))

;;;; Helm
(after "helm-autoloads"
  (require 'helm-config)
  (helm-mode 1)
  (global-unset-key (kbd "M-x"))
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-c m") 'helm-mini)
  (global-set-key (kbd "C-c a") 'helm-do-ag))

;;;; fic mode (FIXME, TODO and BUG highlighting
(after "fic-mode-autoloads"
  (add-hook 'c++-mode-hook 'turn-on-fic-mode))

;;;; Powerline
(after "powerline-autoloads"
  (powerline-default-theme))

(after "haskell-mode"
  (add-hook 'haskell-mode-hook 'turn-on-haskell-indent))

(after "ghc-autoloads"
  (autoload 'ghc-ini "ghc" nil t)
  (autoload 'ghc-debug "ghc" nil t)
  (add-hook 'haskell-mode-hook (lambda () (ghc-init))))

;;;; Neo Tree
(after "neotree-autoloads"
  (require 'neotree)
  (global-set-key (kbd "<f8>") 'neotree-toggle)
  (define-key neotree-mode-map (kbd "j") 'next-line)
  (define-key neotree-mode-map (kbd "k") 'previous-line)
  (define-key neotree-mode-map (kbd "C-w C-l") 'evil-window-right)
  (add-hook 'neotree-mode-hook 'evil-emacs-state))

(after "smart-mode-line-autoloads"
  (sml/setup))

;;;; gdb
(setq
 gdb-many-windows t)

;;;; autopair
(after "autopair-autoloads"
  (autopair-global-mode 1))
