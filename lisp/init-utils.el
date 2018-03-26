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

(req-package git-gutter-fringe
  :require fringe-helper
  :commands git-gutter-mode
  :init
  (defun xy//git-gutter-maybe ()
    (when (and (buffer-file-name)
               (not (file-remote-p (buffer-file-name))))
      (git-gutter-mode t)))
  (add-hook 'prog-mode-hook #'xy//git-gutter-maybe)
  (add-hook 'text-mode-hook #'xy//git-gutter-maybe)
  (add-hook 'conf-mode-hook #'xy//git-gutter-maybe)
  (evil-leader/set-key
    "gd" 'git-gutter:popup-diff)
  :config
  (fringe-helper-define 'git-gutter-fr:added '(center repeated)
    "XXX.....")
  (fringe-helper-define 'git-gutter-fr:modified '(center repeated)
    "XXX.....")
  (fringe-helper-define 'git-gutter-fr:deleted 'bottom
    "X......."
    "XX......"
    "XXX....."
    "XXXX...."))

(req-package git-timemachine
  :require evil-leader
  :commands git-timemachine
  :init
  (evil-leader/set-key
    "gt" 'git-timemachine)
  :config
  (evil-make-overriding-map git-timemachine-mode-map 'normal)
  (add-hook 'git-timemachine-mode-hook #'evil-normalize-keymaps))

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
