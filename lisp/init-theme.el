;; Add custom theme path
(add-to-list 'custom-theme-load-path (concat user-emacs-directory (convert-standard-filename "themes/")))

(use-package doom-themes
  :demand t
  :config
  (if (string-suffix-p "box" (system-name))
      (load-theme 'doom-dark+ t)
    (load-theme 'doom-one-light t))
  (fringe-mode nil))

(provide 'init-theme)
