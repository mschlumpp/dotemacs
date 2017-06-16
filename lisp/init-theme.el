;; Add custom theme path
(add-to-list 'custom-theme-load-path (concat user-emacs-directory (convert-standard-filename "themes/")))

(req-package material-theme
  :config
  (load-theme 'material-light t))

(provide 'init-theme)
