(req-package diminish
  :config
  (diminish 'eldoc-mode)
  (diminish 'subword-mode)
  (diminish 'auto-revert-mode)
  (diminish 'abbrev-mode))

(req-package magit
  :commands magit-status
  :init
  (evil-leader/set-key "gs" 'magit-status)
  :config
  (setq magit-last-seen-setup-instructions "1.4.0"))

(req-package evil-magit
  :require magit
  :init
  (require 'evil-magit))

(req-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode 1)
  (which-key-setup-minibuffer)
  (which-key-add-key-based-replacements
    "SPC w" "window"
    "SPC m" "mode"
    "SPC ." "next buffer"
    "SPC f" "file"
    "SPC b" "buffer"
    "SPC g" "git"
    "SPC q" "quit"))

(provide 'init-utils)
