;;;; Paredit
(defun use-paredit ()
  (electric-pair-mode -1)
  (paredit-mode 1))

(req-package slime
  :require (paredit slime-company)
  :commands (slime)
  :init
  (add-hook 'slime-mode-hook 'use-paredit)
  (add-hook 'slime-repl-mode-hook 'use-paredit)
  :config
  (require 'cl); Seems to be necessary
  (slime-setup '(slime-company slime-fancy))
  (setq inferior-lisp-program "/usr/bin/sbcl"))

(provide 'init-lisp)
