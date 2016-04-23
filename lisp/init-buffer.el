;; Uniquify buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(bind-keys*
 ("C-c o" . ff-find-other-file)
 ("C-c m" . switch-to-buffer))

(use-package projectile
  :ensure t
  :bind ("C-c h" . projectile-find-file)
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (setq projectile-completion-system 'default)
  (projectile-global-mode 1))

;;;; Flycheck
(use-package flycheck
  :commands flycheck-mode-on-safe)

(provide 'init-buffer)
