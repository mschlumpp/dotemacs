(winner-mode t)
(general-def
  "C-M-<left>"  'windmove-left
  "C-M-<right>" 'windmove-right
  "C-M-<up>"    'windmove-up
  "C-M-<down>"  'windmove-down)

(defun hydra-move-splitter-left (arg)
  "Move window splitter left."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'right))
      (shrink-window-horizontally arg)
    (enlarge-window-horizontally arg)))

(defun hydra-move-splitter-right (arg)
  "Move window splitter right."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'right))
      (enlarge-window-horizontally arg)
    (shrink-window-horizontally arg)))

(defun hydra-move-splitter-up (arg)
  "Move window splitter up."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'up))
      (enlarge-window arg)
    (shrink-window arg)))

(defun hydra-move-splitter-down (arg)
  "Move window splitter down."
  (interactive "p")
  (if (let ((windmove-wrap-around))
        (windmove-find-other-window 'up))
      (shrink-window arg)
    (enlarge-window arg)))

;; `hydra-buffer-switch/body' modifies `last-command' on enter and breaks iflipb
(defun quick-buffer//fix-next ()
  (interactive)
  (setq last-command 'iflipb-next-buffer)
  (iflipb-next-buffer nil))

(defun quick-buffer//fix-prev ()
  (interactive)
  (setq last-command 'iflipb-next-buffer)
  (iflipb-previous-buffer))

(use-package iflipb
  :demand t)

(use-package hydra
  :demand t
  :config
  (defhydra hydra-winner (:hint nil)
    "
[_u_] undo [_U_] Redo"
    ("u" winner-undo)
    ("U" winner-redo))

  (defhydra hydra-window (global-map "C-#" :hint nil)
    "
  ^ Movement ^  │   ^  Splits  ^    │  ^ Buffers  ^  │  ^  Other ^
──^──────────^──┴───^──────────^────┴──^──────────^──┴──^────────^─
   [_h_] ←         [_u_] vertical     [_b_] switch      [_z_] undo
   [_j_] ↓         [_i_] horizontal   [_f_] find file   [_Z_] redo
   [_k_] ↑         [_H_] grow left
   [_l_] →         [_L_] grow right
    ^ ^            [_K_] grow up
    ^ ^            [_J_] grow down
   [_SPC_] quit    [_d_] close
"
    ("h" windmove-left)
    ("j" windmove-down)
    ("k" windmove-up)
    ("l" windmove-right)
    ("u" (lambda ()
           (interactive)
           (split-window-right)
           (windmove-right)))
    ("i" (lambda ()
           (interactive)
           (split-window-below)
           (windmove-down)))
    ("H" hydra-move-splitter-left)
    ("L" hydra-move-splitter-right)
    ("K" hydra-move-splitter-up)
    ("J" hydra-move-splitter-down)
    ("d" delete-window)
    ("b" ido-switch-buffer)
    ("f" ido-find-file)
    ("z" winner-undo)
    ("Z" winner-redo)
    ("SPC" nil))

  (defhydra hydra-buffer-switch (:hint nil)
    "
[_,_] prev [_._] next"
    ("," quick-buffer//fix-prev)
    ("." quick-buffer//fix-next))

  (my-leader-def
    "wu" 'hydra-winner/winner-undo
    "." (lambda ()
          (interactive)
          (iflipb-next-buffer nil)
          (hydra-buffer-switch/body))))


;;;; Popwin
(use-package popwin
  :demand t
  :general
  ("C-c w" '(:keymap popwin:keymap))
  (my-leader-def
    "we" 'popwin:messages
    "wg" 'popwin:stick-popup-window
    "wp" 'popwin:select-popup-window
    "wr" 'popwin:display-last-buffer)
  :config
  (popwin-mode)
  (add-to-list 'popwin:special-display-config '("*git-gutter:diff*" :noselect t))
  (add-to-list 'popwin:special-display-config '("*RTags*" :stick t :noselect t :position bottom :width 60))
  (add-to-list 'popwin:special-display-config '("\\*Cargo \\w+\\*" :regexp t :noselect t))
  (add-to-list 'popwin:special-display-config '("*Flycheck errors*" :noselect t))
  (add-to-list 'popwin:special-display-config '("*ggtags-global*" :noselect t)))

(provide 'init-window)
