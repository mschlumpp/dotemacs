;;;; General settings
;; Fix scrolling
(setq mouse-wheel-scroll-amount '(5)
      mouse-wheel-progressive-speed nil)

;; Truncate long lines
(setq-default truncate-lines 1)

;; Backup files
(setq backup-directory-alist `(("." . "~/.saves"))
      delete-old-versions t
      kept-old-versions 2
      kept-new-versions 4
      version-control t)

;;;; Macros
(defmacro after (mode &rest body)
  "`eval-after-load' MODE evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,mode
     '(progn ,@body)))

;;;; Initialize package.el
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa")
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; Make sure use-package is installed
(defun ensure-package (package &optional refresh)
  (unless (package-installed-p package)
    (message "Install missing package %s" package)
    (when refresh
      (package-refresh-contents))
    (package-install package)))

(ensure-package 'bind-key t)
(require 'bind-key)
(ensure-package 'use-package t)
(require 'use-package)
(ensure-package 'req-package t)
(require 'req-package)

(setq use-package-always-ensure t)
(setq use-package-compute-statistics t)

(provide 'init-core)
