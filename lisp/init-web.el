(defun xy//setup-tide ()
  (tide-setup)
  (flycheck-mode 1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode 1)
  (company-mode-on))

(req-package typescript-mode
  :mode ("\\.ts\\'"))

(req-package tide
  :require (typescript-mode)
  :commands (tide-setup tide-mode)
  :init
  (add-hook 'typescript-mode-hook 'xy//setup-tide))

(req-package web-mode
  :mode ("\\.tsx\\'" "\\.html\\'")
  :init
  (when (package-installed-p 'tide)
    (add-hook 'web-mode-hook
              (lambda ()
                (electric-pair-mode -1)
                (when (string-equal "tsx" (file-name-extension buffer-file-name))
                  (xy//setup-tide)))))
  :config
  (setq web-mode-engines-alist
        '(("django" . "\\.html\\'"))))

(req-package emmet-mode
  :require (web-mode)
  :commands emmet-mode
  :init
  (when (package-installed-p 'web-mode)
    (add-hook 'web-mode-hook 'emmet-mode)
    (add-hook 'css-mode-hook 'emmet-mode)))

(provide 'init-web)
