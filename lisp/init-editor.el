(setq-default indent-tabs-mode nil)

(delete-selection-mode t)
(electric-pair-mode t)

(use-package editorconfig
  :ensure t
  :init
  (editorconfig-mode 1))

(use-package anzu
  :ensure t
  :demand t
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp))
  :config
  (global-anzu-mode 1))

(use-package expand-region
  :ensure t
  :commands er/expand-region
  :bind ("C-+" . er/expand-region))

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode 1))

(use-package company
  :ensure t
  :config
  (global-company-mode 1))

(use-package whitespace-cleanup-mode
  :config
  (global-whitespace-cleanup-mode 1))

(provide 'init-editor)
