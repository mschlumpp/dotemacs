(req-package org-mode
  :ensure nil
  :bind (("C-c g" . org-agenda)
         ("C-c c" . org-capture))
  :init
  (add-hook 'org-mode-hook 'visual-line-mode)
  (add-hook 'org-mode-hook 'org-indent-mode)
  (setq org-directory "~/orgmode")
  (setq org-default-notes-file (concat org-directory "/notes.org")))

(provide 'init-org)
