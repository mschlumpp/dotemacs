(setq-default indent-tabs-mode nil)

(delete-selection-mode t)
(electric-pair-mode t)

(bind-keys*
 ("C-;" . comment-line))

(req-package editorconfig
  :diminish
  :init
  (editorconfig-mode 1))

(req-package anzu
  :demand t
  :bind (("M-%" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp)))

(req-package expand-region
  :commands er/expand-region
  :bind ("C-+" . er/expand-region))

(req-package undo-tree
  :diminish undo-tree-mode
  :ensure t
  :config
  (global-undo-tree-mode 1))

(req-package company
  :config
  (global-company-mode 1)
  (global-set-key (kbd "M-TAB") #'company-complete)
  (setq company-tooltip-align-annotations t)
  (define-key company-active-map (kbd "C-j") #'company-select-next)
  (define-key company-active-map (kbd "C-k") #'company-select-previous)
  (define-key company-active-map (kbd "C-l") #'company-complete-selection))

(req-package company-flx
  :require company
  :config
  (company-flx-mode 1))
(req-package company-statistics
  :require company
  :config
  (company-statistics-mode 1))
(req-package company-quickhelp
  :require company
  :config
  (company-quickhelp-mode 1))

(req-package ws-butler
  :hook ((prog-mode conf-mode org-mode) . ws-butler-mode))

(req-package markdown-mode
  :mode "\\.md\\'"
  :config
  (add-hook 'markdown-mode-hook #'ws-butler-mode)
  (add-hook 'markdown-mode-hook #'(lambda () (setq truncate-lines nil))))

(req-package yasnippet)

(provide 'init-editor)
