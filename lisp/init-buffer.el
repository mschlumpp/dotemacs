;; Uniquify buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(bind-keys*
 ("C-c o" . ff-find-other-file)
 ("C-c m" . switch-to-buffer)
 ("M-n" . next-error)
 ("M-p" . previous-error))

(req-package projectile
  :require counsel ; for counsel-rg
  :bind ("C-c h" . projectile-find-file)
  :bind-keymap ("C-c p" . projectile-command-map)
  :commands (projectile-project-root)
  :init
  (bind-key "C-c a" (lambda ()
                      "Run counsel-rg in the current project root"
                      (interactive)
                      (counsel-rg nil (projectile-project-root))))
  :config
  (setq projectile-completion-system 'default)
  (projectile-global-mode 1))

;;;; Flycheck
(req-package flycheck
  :commands flycheck-mode-on-safe
  :init
  (add-hook 'c++-mode-hook (lambda () (flycheck-mode-on-safe))))

(provide 'init-buffer)
