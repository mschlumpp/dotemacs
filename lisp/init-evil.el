(req-package evil
  :config
  (evil-mode 1)
  (setq evil-want-fine-undo t)
  (define-key evil-motion-state-map (kbd "K") nil)
  (define-key evil-normal-state-map (kbd "M-.") nil))

(req-package evil-escape
  :diminish evil-escape-mode
  :require evil
  :config
  (evil-escape-mode 1)
  (setq-default evil-escape-delay 0.05)
  (setq-default evil-escape-unordered-key-sequence t)
  (setq-default evil-escape-key-sequence "jk"))

(req-package evil-leader
  :require evil
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
    "qq" 'save-buffers-kill-terminal
    "wc" 'delete-window
    "wm" 'delete-other-windows; TODO: Replace this with maximize-window from spacemacs
    "wv" 'evil-window-vsplit
    "ws" 'evil-window-split
    "wh" 'evil-window-left
    "wl" 'evil-window-right
    "wk" 'evil-window-up
    "wj" 'evil-window-down))

(provide 'init-evil)
