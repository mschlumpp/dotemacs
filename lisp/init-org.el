(req-package org-mode
  :ensure nil
  :bind (("C-c g" . org-agenda)
         ("C-c c" . org-capture))
  :init
  (add-hook 'org-mode-hook 'visual-line-mode)
  (add-hook 'org-mode-hook 'org-indent-mode)
  (setq org-directory "~/orgmode")
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  :config
  (when (equal (system-name) "fedtop")
    (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))))

(provide 'init-org)
