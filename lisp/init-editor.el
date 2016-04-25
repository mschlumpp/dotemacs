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
  (global-company-mode 1)
  (global-set-key (kbd "M-TAB") #'company-complete)
  (define-key company-active-map (kbd "C-j") #'company-select-next)
  (define-key company-active-map (kbd "C-k") #'company-select-previous)
  (define-key company-active-map (kbd "C-l") #'company-complete-selection)

  (use-package company-flx
    :ensure t
    :config
    (company-flx-mode 1))
  (use-package company-statistics
    :ensure t
    :config
    (company-statistics-mode 1))
  (use-package company-quickhelp
    :ensure t
    :config
    (company-quickhelp-mode 1)))

(use-package whitespace-cleanup-mode
  :config
  (global-whitespace-cleanup-mode 1))

(provide 'init-editor)
