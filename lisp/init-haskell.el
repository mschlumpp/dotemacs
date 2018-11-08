(req-package haskell-mode
  :mode "\\.hs\\'"
  :config
  (add-hook 'haskell-mode 'interactive-haskell-mode))

(provide 'init-haskell)
