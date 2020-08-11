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

;;;; Initialize package.el
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa")
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Make sure use-package is installed
(defun ensure-package (package &optional refresh)
  (unless (package-installed-p package)
    (message "Install missing package %s" package)
    (when refresh
      (package-refresh-contents))
    (package-install package)))

(require 'cl)
(defun xy//ensure-packages (packages)
  "Ensure that the specified list of packages are installed and loaded"
  (let ((pkgs (cl-map 'list (lambda (p) (cons p (package-installed-p p))) packages)))
    (when (notevery #'cdr pkgs)
      (package-refresh-contents))
    (dolist (p pkgs)
      (unless (cdr p)
        (package-install (car p)))
      (require (car p)))))

(xy//ensure-packages
 '(bind-key
   use-package))

(setq use-package-always-defer t)
(setq use-package-always-ensure t)
(setq use-package-compute-statistics t)

(use-package diminish
  :demand t
  :config
  (diminish 'eldoc-mode)
  (diminish 'subword-mode)
  (diminish 'auto-revert-mode)
  (diminish 'abbrev-mode))

(use-package general
  :demand t
  :config
  (general-create-definer my-leader-def
    :keymaps 'override
    :states '(normal visual)
    :prefix "SPC"))

(provide 'init-core)

