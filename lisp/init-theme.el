;; Add custom theme path
(add-to-list 'custom-theme-load-path (concat user-emacs-directory (convert-standard-filename "themes/")))

(req-package doom-themes
  :config
  (if (equal (system-name) "archbox")
      (load-theme 'doom-one t)
    (load-theme 'doom-one-light t))
  (fringe-mode nil))

(provide 'init-theme)
