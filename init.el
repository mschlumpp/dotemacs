;; init.el --- The new config file

;; Increase GC Threshold
(setq gc-cons-threshold 20000000)

(add-to-list 'load-path (concat user-emacs-directory "lisp"))

;;;; Put Customize stuff into separate file
(setq custom-file (concat user-emacs-directory (convert-standard-filename "custom.el")))
(load custom-file 'noerror)

;; straight.el somehow messes up tramp package. Load bundled tramp
;; before straight introduces the broken package
(require 'tramp)

(require 'init-core)
(require 'init-evil)
(require 'init-appearance)
(require 'init-theme)
(require 'init-editor)
(require 'init-navigation)
(require 'init-utils)
(require 'init-window)
(require 'init-buffer)
(require 'init-lsp)
(require 'init-c++)
;; (require 'init-tex)
(require 'init-rust)
(require 'init-web)
(require 'init-auto-insert)
(require 'init-org)
(require 'init-haskell)

;; Reset GC Threshold
(setq gc-cons-threshold 800000)
