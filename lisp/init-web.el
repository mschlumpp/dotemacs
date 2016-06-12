(defun xy//setup-tide ()
  (tide-setup)
  (flycheck-mode 1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode 1)
  (company-mode-on))

(use-package tide
  :init
  (add-hook 'typescript-mode-hook 'xy//setup-tide))

(use-package web-mode
  :init
  (when (package-installed-p 'tide)
    (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
    (add-hook 'web-mode-hook
              (lambda ()
                (when (string-equal "tsx" (file-name-extension buffer-file-name))
                  (xy//setup-tide))))))

(provide 'init-web)
