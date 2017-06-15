(after "cc-mode"
  (add-hook 'c++-mode-hook (lambda () (subword-mode 1)))
  (c-add-style "unknown"
               '("java"
                 (c-offsets-alist
                  (topmost-intro-cont . 0)
                  (access-label . -)
                  (inclass . +))))
  (setq c-default-style "unknown"
        indent-tabs-mode 0
        c-basic-offset 4
        c-cleanup-list '(defun-close-semi
                          scope-operator
                          empty-defun-braces))

  (defadvice c-lineup-arglist (around lambda-lineup activate)
    "Improve indentation of continued C++11 lambda function opened as argument."
    (setq ad-return-value
          (if (and (equal major-mode 'c++-mode)
                   (ignore-errors
                     (save-excursion
                       (goto-char (c-langelem-pos langelem))
                       ;; Detect "[...](" or "[...]{". preceded by "," or "(",
                       ;;   and with unclosed brace.
                       (looking-at ".*[(,][ \t]*\\[[^]]*\\][ \t]*[({][^}]*$"))))
              0                           ; no additional indent
            ad-do-it))))

(req-package fic-mode
  :commands (turn-on-fic-mode)
  :init
  (add-hook 'c++-mode-hook 'fic-mode))

(req-package cpputils-cmake
  :commands cppcm-reload-all
  :init
  (add-hook 'c-mode-common-hook (lambda ()
                                  (if (derived-mode-p 'c-mode 'c++-mode)
                                      (cppcm-reload-all))))
  :config
  (setq cppcm-write-flymake-makefile nil))

(req-package rtags
  :commands (rtags-find-symbol-at-point rtags-location-stack-back)
  :bind (("C-c r ," . rtags-find-references-at-point)
         ("C-c r v" . rtags-find-virtuals-at-point)
         ("C-c r h" . rtags-print-class-hierarchy)
         ("C-c r f" . rtags-fixit)
         ("C-c r r" . rtags-rename-symbol)
         ("C-M-8" . rtags-previous-match)
         ("C-M-9" . rtags-next-match))
  :init
  (add-to-list 'evil-emacs-state-modes 'rtags-mode)
  (add-hook 'c-mode-common-hook (lambda ()
                                 (define-key c-mode-base-map (kbd "M-.") 'rtags-find-symbol-at-point)
                                 (define-key c-mode-base-map (kbd "M-,") 'rtags-location-stack-back))))

;;;; ycmd
(req-package ycmd
  :diminish "ⓨ"
  :init
  (set-variable 'ycmd-server-command '("python" "/home/marco/.emacs.d/ycmd/ycmd"))
  (set-variable 'ycmd-extra-conf-whitelist '("~/Projekte/*"))
  :config
  (setq-default ycmd-parse-conditions '(save new-line idle-change))
  (when (require 'ycmd-eldoc nil t)
    (add-hook 'ycmd-mode-hook 'ycmd-eldoc-setup))
  (global-ycmd-mode 1))

(req-package company-ycmd
  :config
  (company-ycmd-setup))

(req-package flycheck-ycmd
  :config
  (flycheck-ycmd-setup))

;;;; clang-format
(req-package clang-format
  :init
  (evil-leader/set-key
    "mff" 'clang-format-buffer
    "mfr" 'clang-format-region))

;;;; gdb
(setq gdb-many-windows t)

(provide 'init-c++)
