(req-package tex
  :require (flycheck)
  :ensure auctex
  :init
  (add-hook 'latex-mode-hook 'flycheck-mode-on-safe)
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (setq-default TeX-engine 'luatex)
  (setq TeX-source-correlate-mode t))

(provide 'init-tex)
