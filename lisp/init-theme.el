;; Add custom theme path
(add-to-list 'custom-theme-load-path (concat user-emacs-directory (convert-standard-filename "themes/")))

(use-package doom-themes
  :demand t
  :config
  (if (equal (system-name) "susebox")
      (load-theme 'doom-one t)
    (load-theme 'doom-one-light t))
  (fringe-mode nil))

(provide 'init-theme)
