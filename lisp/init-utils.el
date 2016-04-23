(use-package magit
  :commands magit-status
  :init
  (use-package evil-magit
    :ensure t
    :init
    (require 'evil-magit))
  (evil-leader/set-key "gs" 'magit-status)
  :config
  (setq magit-last-seen-setup-instructions "1.4.0"))

(use-package which-key
  :config
  (which-key-mode 1)
  (which-key-setup-minibuffer))

(provide 'init-utils)
