(use-package evil
  :demand t
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (setq evil-want-fine-undo t)
  (general-unbind 'insert "C-k")        ; Disable digraph insertion
  (general-unbind 'motion "K")          ; Disable help (man page) lookup
  (general-unbind 'normal "M-."))

(use-package evil-collection
  :demand t
  :init
  (setq evil-collection-company-use-tng nil)
  :config
  (evil-collection-init))

(use-package evil-escape
  :diminish evil-escape-mode
  :demand t
  :config
  (evil-escape-mode 1)
  (setq-default evil-escape-delay 0.05)
  (setq-default evil-escape-unordered-key-sequence t)
  (setq-default evil-escape-key-sequence "jk"))

(use-package evil-snipe
  :demand t
  :config
  (evil-snipe-override-mode))

(my-leader-def
  "SPC" 'counsel-M-x
  ;; Files
  "ff" 'find-file
  "fs" 'save-buffer
  "fS" 'evil-write-all
  ;; Buffer
  "bb" 'switch-to-buffer
  "bk" 'kill-current-buffer
  ;; Windows
  "qq" 'save-buffers-kill-terminal
  "wc" 'delete-window
  "wm" 'delete-other-windows; TODO: Replace this with maximize-window from spacemacs
  "wv" 'evil-window-vsplit
  "ws" 'evil-window-split
  "wh" 'evil-window-left
  "wl" 'evil-window-right
  "wk" 'evil-window-up
  "wj" 'evil-window-down)

(provide 'init-evil)
