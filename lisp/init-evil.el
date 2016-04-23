(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package evil-escape
  :ensure t
  :config
  (evil-escape-mode 1)
  (setq-default evil-escape-delay 0.05)
  (setq-default evil-escape-unordered-key-sequence t)
  (setq-default evil-escape-key-sequence "jk"))

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode 1)
  (evil-leader/set-leader "<SPC>")
  ; Bind some basics
  (evil-leader/set-key
    "<SPC>" 'counsel-M-x
    ;; Files
    "ff" 'find-file
    "fs" 'save-buffer
    "fS" 'evil-write-all
    ;; Buffer
    "bb" 'switch-to-buffer
    "bk" 'kill-buffer
    ;; Windows
    "wc" 'delete-window
    "wm" 'delete-other-windows; TODO: Replace this with maximize-window from spacemacs
    "wv" 'evil-window-vsplit
    "ws" 'evil-window-split
    "wh" 'evil-window-left
    "wl" 'evil-window-right
    "wk" 'evil-window-up
    "wj" 'evil-window-down))

(provide 'init-evil)
