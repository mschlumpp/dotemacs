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
  :requires (hydra)
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
                                 (define-key c-mode-base-map (kbd "M-,") 'rtags-location-stack-back)))
  :config
  (defhydra hydra-rtags-navigation (:hint nil :foreign-keys run)
    "
         [_ö_] quit
matches: [_p_] previous [_n_] next [_,_] back
search:  [_._] symbol   [_r_] refs [_v_] virtuals
print:   [_c_] class hierarchy"
    ("n" rtags-next-match)
    ("p" rtags-previous-match)
    ("," rtags-location-stack-back)
    ("." rtags-find-symbol-at-point)
    ("r" rtags-find-references-at-point)
    ("v" rtags-find-virtuals-at-point)
    ("c" rtags-print-class-hierarchy)
    ("ö" nil)))

;;;; ycmd
(req-package ycmd
  :diminish "ⓨ"
  :init
  (add-hook 'c++-mode-hook #'(lambda ()
                               (ycmd-mode 1)))
  :config
  (setq ycmd-extra-conf-whitelist '("~/Projekte/*")
        ycmd-parse-conditions '(save new-line idle-change)))

(req-package ycmd-eldoc
  :requires (ycmd)
  :commands (ycmd-eldoc-setup)
  :init
  (add-hook 'ycmd-mode-hook 'ycmd-eldoc-setup))

(req-package company-ycmd
  :requires (ycmd company)
  :commands (company-ycmd-setup)
  :init
  (add-hook 'ycmd-mode-hook #'company-ycmd-setup))

(req-package flycheck-ycmd
  :requires (ycmd flycheck)
  :init
  (add-hook 'ycmd-mode-hook #'flycheck-ycmd-setup))

;;;; clang-format
(req-package clang-format
  :init
  (evil-leader/set-key
    "mff" 'clang-format-buffer
    "mfr" 'clang-format-region))

;;;; gdb
(setq gdb-many-windows t)

(provide 'init-c++)
