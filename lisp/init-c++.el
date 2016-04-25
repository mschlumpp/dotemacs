(after "cc-mode"
  (add-hook 'c++-mode-hook (lambda () (subword-mode 1)))
  (c-add-style "unknown"
               '("java"
                 (c-offsets-alist
                  (access-label . -2)
                  (inclass . 2))))
  (setq c-default-style "unknown"
        indent-tabs-mode 0
        c-basic-offset 4
        c-cleanup-list '(defun-close-semi
                          scope-operator
                          empty-defun-braces)))

(use-package fic-mode
  :commands (turn-on-fic-mode)
  :init
  (add-hook 'c++-mode-hook 'fic-mode))

(use-package cpputils-cmake
  :commands cppcm-reload-all
  :init
  (add-hook 'c-mode-common-hook (lambda ()
                                  (if (derived-mode-p 'c-mode 'c++-mode)
                                      (cppcm-reload-all))))
  :config
  (setq cppcm-write-flymake-makefile nil))

(use-package rtags
  :commands (rtags-find-symbol-at-point rtags-location-stack-back)
  :bind (("C-c r ," . rtags-find-references-at-point)
         ("C-c r v" . rtags-find-virtuals-at-point)
         ("C-c r h" . rtags-print-class-hierarchy)
         ("C-c r f" . rtags-fixit)
         ("C-c r r" . rtags-rename-symbol)
         ("C-M-8" . rtags-previous-match)
         ("C-M-9" . rtags-next-match))
  :init
  (add-hook 'c-mode-common-hook (lambda ()
                                 (define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
                                 (define-key c-mode-base-map (kbd "M-,") 'rtags-location-stack-back))))

;;;; ycmd
(use-package ycmd
  :init
  (require 'ycmd-eldoc)
  (add-hook 'ycmd-mode-hook 'ycmd-eldoc-setup)
  (set-variable 'ycmd-server-command '("python" "/home/marco/.emacs.d/ycmd/ycmd"))
  (set-variable 'ycmd-extra-conf-whitelist '("~/Projekte/*"))
  (global-ycmd-mode 1))

(use-package company-ycmd
  :init
  (company-ycmd-setup))

(use-package flycheck-ycmd
  :init
  (flycheck-ycmd-setup))

;;;; clang-format
(use-package clang-format
  :bind ("C-<tab>" . clang-format-region))

;;;; gdb
(setq gdb-many-windows t)

(provide 'init-c++)
