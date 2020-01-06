;; Uniquify buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(bind-keys*
 ("C-c o" . ff-find-other-file)
 ("C-c m" . switch-to-buffer)
 ("M->" . xref-find-references)
 ("M-n" . next-error)
 ("M-p" . previous-error))

(use-package projectile
  :bind ("C-c h" . projectile-find-file)
  :bind-keymap ("C-c p" . projectile-command-map)
  :demand t
  :init
  (defun xy//search-rg ()
    (interactive)
    (counsel-rg nil (projectile-project-root)))
  :config
  (evil-leader/set-key
    "p" projectile-command-map
    "a" 'xy//search-rg)
  (setq projectile-completion-system 'default)
  (projectile-global-mode 1))

;;;; Flycheck
(use-package flycheck
  :commands flycheck-mode
  :hook ((c++-mode c-mode) . flycheck-mode))

(use-package flycheck-posframe
  :init
  (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode)
  :config
  (flycheck-posframe-configure-pretty-defaults))

(provide 'init-buffer)
