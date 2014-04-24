;; init.el --- The new config file

;; Customize variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a774c5551bc56d7a9c362dca4d73a374582caedb110c201a09b410c0ebbb5e70" "fd17ed452917381dfc76ee1af7699c45ca21f182f869085e247e9d5ab7ec812a" default))))

;;; Disable Toolbars and other ugly stuff
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-startup-screen t)

;;; General settings
;; Increase GC Threshold
(setq gc-cons-threshold 20000000)
;; Fix scrolling
(setq mouse-wheel-scroll-amount '(5))
;; Don't blink
(blink-cursor-mode -1)
;; Column numbers
(column-number-mode t)

(delete-selection-mode t)

(setq-default show-trailing-whitespace t
	      indent-tabs-mode nil
	      echo-keystrokes 0.5)

;; Uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;;; Modes
(show-paren-mode t)

;;;; Package managment
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa")
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

;;;; sublime-themes
(load-theme 'brin)

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
	  auto-complete
	  grizzl
	  projectile
	  flx
	  flx-ido)))

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
(after "smex-autoloads"
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command))

(after "ido-ubiquitous-autoloads"
  (require 'ido-ubiquitous)
  (ido-mode t)
  (ido-ubiquitous-mode t))

(after "flx-ido-autoloads"
  (flx-ido-mode t)
  (setq ido-use-faces nil))

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
  (setq projectile-completition-system 'grizzl
	projectile-show-paths-function 'projectile-hashify-with-relative-paths))

;;;; Auto-complete
(after "auto-complete-autoloads"
  (require 'auto-complete-config)
  (ac-config-default)
  (setq ac-use-menu-map t
	ac-use-fuzzy t)
  (ac-set-trigger-key "\C-TAB")
  (define-key ac-menu-map "\C-n" 'ac-next)
  (define-key ac-menu-map "\C-p" 'ac-previous)
  (global-auto-complete-mode t))

;;;; rtags
(after "rtags-autoloads"
  (require 'rtags)
  (require 'rtags-ac)
  (rtags-enable-standard-keybindings c-mode-base-map)
  (add-hook 'c-mode-common-hook (lambda () (setq ac-sources (append '(ac-source-rtags) ac-sources)))))

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
