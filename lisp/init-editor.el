(setq-default indent-tabs-mode nil)

(delete-selection-mode t)
(electric-pair-mode t)

(general-def
 "C-;" 'comment-line)

(use-package editorconfig
  :diminish
  :demand t
  :config
  (editorconfig-mode 1))

(use-package dtrt-indent
  :diminish dtrt-indent-mode
  :demand t
  :config
  (dtrt-indent-global-mode 1))

(use-package anzu
  :general
  ("M-%" 'anzu-query-replace)
  ("C-M-%" 'anzu-query-replace-regexp))

(use-package expand-region
  :commands er/expand-region
  :general
  (my-leader-def
    "=" 'er/expand-region))

(use-package undo-tree
  :diminish undo-tree-mode
  :ensure t
  :config
  (global-undo-tree-mode 1))

(use-package tramp
  :config
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  ;; Some performance settings
  (setq remote-file-name-inhibit-cache nil)
  (setq vc-ignore-dir-regexp
        (format "%s\\|%s"
                vc-ignore-dir-regexp
                tramp-file-name-regexp)))

(use-package company
  :demand t
  :general
  ('insert
   "M-RET" 'company-complete)
  (company-mode-map
   "TAB" 'company-indent-or-complete-common)
  (company-active-map
   "<tab>" 'company-complete-common-or-cycle
   "TAB" 'company-complete-common-or-cycle
   "C-l" 'company-complete-selection)
  :config
  (global-company-mode 1)
  (setq company-tooltip-align-annotations t))

(use-package company-flx
  :demand t
  :config
  (company-flx-mode 1))
(use-package company-quickhelp
  :demand t
  :config
  (company-quickhelp-mode 1))

(use-package ws-butler
  :hook ((prog-mode conf-mode org-mode) . ws-butler-mode))

(use-package markdown-mode
  :mode "\\.md\\'"
  :config
  (add-hook 'markdown-mode-hook #'ws-butler-mode)
  (add-hook 'markdown-mode-hook #'(lambda () (setq truncate-lines nil))))

(use-package yasnippet)

(use-package highlight-indent-guides
  :commands highlight-indent-guides-mode
  :config
  (setq highlight-indent-guides-method 'character
        highlight-indent-guides-responsive 'top))

(use-package olivetti
  :config
  (setq-default olivetti-body-width 94))

(use-package no-littering
  :demand t
  :config
  (require 'recentf)
  (add-to-list 'recentf-exclude no-littering-var-directory)
  (add-to-list 'recentf-exclude no-littering-etc-directory))

(provide 'init-editor)
