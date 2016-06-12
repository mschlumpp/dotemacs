;; Add custom theme path
(add-to-list 'custom-theme-load-path (concat user-emacs-directory (convert-standard-filename "themes/")))

(use-package material-theme
  :init
  (load-theme 'material-light t))

(provide 'init-theme)
