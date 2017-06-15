;;;; jedi -- python auto complete
(req-package jedi
  :commands jedi:setup
  :init
  (add-hook 'python-mode-hook 'jedi:setup))

(provide 'init-python)
