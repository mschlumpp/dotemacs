(auto-insert-mode 1)
(setq auto-insert-alist '())            ; Clear weird templates

(define-auto-insert
  '("\\.\\(hxx\\|hpp\\|h++\\)\\'" . "C++ header skeleton")
  '("Short description"
    "#pragma once\n\n"
    _))

(define-auto-insert
  '("\\.\\(cxx\\|cpp\\|c++\\)\\'" . "C++ source skeleton")
  '("Short description"
    "#include \""
    (let ((stem (file-name-sans-extension buffer-file-name))
          ret)
      (dolist (ext '("H" "h" "hh" "hpp" "hxx" "h++") ret)
        (when (file-exists-p (concat stem "." ext))
          (setq ret (file-name-nondirectory (concat stem "." ext))))))
    & ?\" | -10))

(provide 'init-auto-insert)
