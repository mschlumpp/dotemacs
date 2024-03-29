(use-package org
  :general
  (my-leader-def
    "og" 'org-agenda
    "ol" 'org-store-link
    "oc" 'org-capture)
  (my-leader-def
    :keymaps 'org-mode-map
    "mci" 'org-clock-in
    "mco" 'org-clock-out)
  (:states 'normal
           :keymaps 'org-mode-map
           "RET" 'org-open-at-point
           "M-." 'org-open-at-point
           "M-," 'org-mark-ring-goto)
  :init
  (add-hook 'org-mode-hook 'visual-line-mode)
  (add-hook 'org-mode-hook 'org-indent-mode)
  :config
  (setq org-latex-listings t)
  (add-to-list 'org-latex-packages-alist '("" "listings"))
  (add-to-list 'org-latex-packages-alist '("" "color"))
  (setq org-directory "~/orgmode")
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  (setq org-refile-targets
        '((org-agenda-files :maxlevel . 1)))
  (when (equal (system-name) "fedtop")
    (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))))

(provide 'init-org)
