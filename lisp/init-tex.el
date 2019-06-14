(req-package tex
  :ensure auctex
  :mode ("\\.tex\\'" . latex-mode)
  :config
  (add-hook 'LaTeX-mode-hook 'olivetti-mode)
  (add-hook 'LaTeX-mode-hook 'flycheck-mode)
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  (add-hook 'LaTeX-mode-hook 'hl-todo-mode)
  (add-hook 'LaTeX-mode-hook 'ws-butler-mode)
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (setq-default TeX-engine 'luatex)
  (setq TeX-source-correlate-mode t))

(provide 'init-tex)
