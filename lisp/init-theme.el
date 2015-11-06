;; Add custom theme path
(add-to-list 'custom-theme-load-path (concat user-emacs-directory (convert-standard-filename "themes/")))

(use-package zerodark-theme
  :init
  (load-theme 'zerodark t))

(provide 'init-theme)
