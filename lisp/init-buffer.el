;; Uniquify buffer names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(bind-keys*
 ("C-c o" . ff-find-other-file)
 ("C-c m" . switch-to-buffer)
 ("M-ß" . xref-find-references)
 ("M-n" . next-error)
 ("M-p" . previous-error))

(req-package projectile
  :require counsel ; for counsel-rg
  :bind ("C-c h" . projectile-find-file)
  :bind-keymap ("C-c p" . projectile-command-map)
  :demand t
  :init
  (defun xy//search-rg ()
    (interactive)
    (counsel-rg nil (projectile-project-root)))
  (bind-key "C-c a" 'xy//search-rg)
  :config
  (evil-leader/set-key
    "p" projectile-command-map
    "a" 'xy//search-rg)
  (setq projectile-completion-system 'default)
  (projectile-global-mode 1))

;;;; Flycheck
(req-package flycheck
  :commands flycheck-mode-on-safe
  :init
  (add-hook 'c++-mode-hook 'flycheck-mode-on-safe)
  (add-hook 'c-mode-hook 'flycheck-mode-on-safe))

(provide 'init-buffer)
