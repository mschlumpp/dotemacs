(req-package tex
  :ensure auctex
  :mode ("\\.tex\\'" . latex-mode)
  :init
  :config
  (add-hook 'LaTeX-mode-hook 'flycheck-mode-on-safe)
  (add-hook 'LaTeX-mode-hook 'hl-todo-mode)
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (setq-default TeX-engine 'luatex)
  (setq TeX-source-correlate-mode t))

(provide 'init-tex)
