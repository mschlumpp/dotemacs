(use-package magit
  :commands magit-status
  :general
  (my-leader-def
    "gs" 'magit-status
    "gp" 'magit-file-dispatch)
  :config
  (use-package evil-magit
    :demand t
    :config
    (require 'evil-magit))
  (magit-wip-mode t)
  (setq magit-revision-show-gravatars '("^Author:     " . "^Commit:     "))
  (setq magit-last-seen-setup-instructions "1.4.0"))


(use-package git-gutter
  :general
  (my-leader-def
    "gd" 'git-gutter:popup-diff)
  :init
  (defun xy//git-gutter-maybe ()
    (when (and (buffer-file-name)
               (not (file-remote-p (buffer-file-name))))
      (git-gutter-mode t)))
  (add-hook 'prog-mode-hook #'xy//git-gutter-maybe)
  (add-hook 'text-mode-hook #'xy//git-gutter-maybe)
  (add-hook 'conf-mode-hook #'xy//git-gutter-maybe))

(use-package git-gutter-fringe
  :demand t
  :config
  (require 'git-gutter-fringe)
  (fringe-helper-define 'git-gutter-fr:added '(center repeated)
    "XXX.....")
  (fringe-helper-define 'git-gutter-fr:modified '(center repeated)
    "XXX.....")
  (fringe-helper-define 'git-gutter-fr:deleted 'bottom
    "X......."
    "XX......"
    "XXX....."
    "XXXX...."))

(use-package git-timemachine
  :commands git-timemachine
  :general
  (my-leader-def
    "gt" 'git-timemachine)
  :config
  (evil-make-overriding-map git-timemachine-mode-map 'normal)
  (add-hook 'git-timemachine-mode-hook #'evil-normalize-keymaps))

(use-package which-key
  :diminish which-key-mode
  :demand t
  :config
  (which-key-mode 1)
  (which-key-setup-minibuffer)
  (which-key-add-key-based-replacements
    "SPC w" "window"
    "SPC m" "mode"
    "SPC ." "next buffer"
    "SPC t" "toggles"
    "SPC f" "file"
    "SPC u" "utils"
    "SPC p" "projects"
    "SPC b" "buffer"
    "SPC o" "org-mode"
    "SPC g" "git"
    "SPC q" "quit"))

(use-package helpful
  :general
  ("C-h f" 'helpful-callable
   "C-h v" 'helpful-variable
   "C-h k" 'helpful-key))

(use-package vterm
  :defer t
  :general
  (my-leader-def
    "uT" 'vterm
    "ut" 'vterm-other-window))

(provide 'init-utils)
