(req-package diminish
  :config
  (diminish 'auto-revert-mode "ⓐ")
  (diminish 'eldoc-mode "Ⓓ"))

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
  (which-key-setup-minibuffer))

(provide 'init-utils)
