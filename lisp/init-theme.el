;; Add custom theme path
(add-to-list 'custom-theme-load-path (concat user-emacs-directory (convert-standard-filename "themes/")))
(add-to-list 'custom-theme-load-path (concat user-emacs-directory (convert-standard-filename "themes/doom-one")))
(add-to-list 'load-path (concat user-emacs-directory (convert-standard-filename "themes/doom-one")))

(use-package material-theme
  :ensure t
  :config
  (load-theme 'material-light t))

(provide 'init-theme)
