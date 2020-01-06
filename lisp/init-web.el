(use-package typescript-mode
  :mode ("\\.ts\\'"))

(use-package web-mode
  :mode ("\\.tsx\\'" "\\.html\\'")
  :config
  (setq web-mode-engines-alist
        '(("django" . "\\.html\\'"))))

(use-package emmet-mode
  :commands emmet-mode
  :init
  (add-hook 'web-mode-hook 'emmet-mode))

(provide 'init-web)
