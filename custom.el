;; Customize variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Linum-format "%7i ")
 '(ansi-color-names-vector
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#839496"])
 '(background-color "#202020")
 '(background-mode dark)
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(compilation-message-face (quote default))
 '(cursor-color "#cccccc")
 '(custom-safe-themes
   (quote
    ("7a778124fe4474197006e6131acead2b32acc8dd06be7c70a1b2a5f0fec5f0ee" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "c3b79a6eed3dac3e86f48d06f61c3fd1c7d73b647af0ddaf36a673c006f1a8eb" "255104c2f5c857498231bc7efbd374026e4ad43547d6fdb4c08be95bc9c871bd" "c5a044ba03d43a725bd79700087dea813abcb6beb6be08c7eb3303ed90782482" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" "7bf64a1839bf4dbc61395bd034c21204f652185d17084761a648251041b70233" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "ef43b291f7e96826d3d9bae61434a93020d0f529d609bc8be5b331980e8448d7" default)))
 '(diary-entry-marker (quote font-lock-variable-name-face))
 '(fci-rule-character-color "#202020")
 '(fci-rule-color "#202020")
 '(flycheck-disabled-checkers (quote (c/c++-clang c/c++-gcc)))
 '(foreground-color "#cccccc")
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(indicate-empty-lines t)
 '(linum-format " %5i ")
 '(magit-diff-use-overlays nil)
 '(magit-log-arguments (quote ("--graph" "--color" "--decorate")))
 '(magit-use-overlays nil)
 '(org-agenda-files (quote ("~/org/notes.org")))
 '(package-selected-packages
   (quote
    (spaceline auctex auctex-latexmk pandoc-mode langtool tide dracula-theme go-eldoc company-go spacemacs-theme evil-magit evil-leader evil-escape evil iflipb material-theme use-package paradox beacon company-irony-c-headers counsel geiser tango-plus-theme company-dcd d-mode rainbow-identifiers virtualenvwrapper multiple-cursors lispy jsx-mode free-keys editorconfig clang-format ido-vertical-mode helm-themes color-identifiers-mode sublimity helm-gitignore gitignore-mode async smex ido-ubiquitous typescript-mode popwin hydra which-key avy smart-mode-line ghc haskell-mode js2-mode clojure-mode whitespace-cleanup-mode anzu expand-region noctilux-theme jedi esup rtags eval-sexp-fu slime-company company-c-headers smartparens elm-mode flycheck-rust rust-mode zerodark-theme cpputils-cmake bison-mode projectile web-mode elixir-mode alchemist adoc-mode css-eldoc goto-chg paredit undo-tree rainbow-blocks rainbow-delimiters stgit magit-stgit rnc-mode yasnippet yaml-mode tup-mode toml-mode sublime-themes stekene-theme spacegray-theme soothe-theme solarized-theme scion plantuml-mode planet-theme noflet neotree markdown-mode+ lua-mode latex-preview-pane json-mode irony-eldoc highlight-indentation hamlet-mode git-gutter-fringe+ fuzzy flycheck-irony flx-ido fic-mode company-irony cmake-mode ag)))
 '(paradox-github-token t)
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(racer-cmd "/home/marco/src/racer/target/release/racer")
 '(racer-rust-src-path "/home/marco/src/rust/src/")
 '(rainbow-identifiers-cie-l*a*b*-lightness 25)
 '(rainbow-identifiers-cie-l*a*b*-saturation 40)
 '(rng-schema-locating-files
   (quote
    ("/home/marco/.schema/schemas.xml" "schemas.xml" "/usr/share/emacs/25.0.50/etc/schema/schemas.xml")))
 '(rtas-path "/home/marco/src/rtags/build/")
 '(safe-local-variable-values
   (quote
    ((hamlet/basic-offset . 4)
     (haskell-process-use-ghci . t)
     (haskell-indent-spaces . 4))))
 '(show-paren-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(tabbar-background-color "#ffffff")
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))
