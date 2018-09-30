;;;; jedi -- python auto complete
(req-package jedi
  :hook (python-mode . jedi:setup))

(provide 'init-python)
