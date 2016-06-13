(winner-mode t)
(windmove-default-keybindings)

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
  :ensure t)

(use-package hydra
  :ensure t
  :config
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

  (defhydra hydra-rtags-navigation (:hint nil :foreign-keys run)
    "
         [_ö_] quit
matches: [_p_] previous [_n_] next [_,_] back
search:  [_._] symbol   [_r_] refs [_v_] virtuals
print:   [_c_] class hierarchy"
    ("n" rtags-next-match)
    ("p" rtags-previous-match)
    ("," rtags-location-stack-back)
    ("." rtags-find-symbol-at-point)
    ("r" rtags-find-references-at-point)
    ("v" rtags-find-virtuals-at-point)
    ("c" rtags-print-class-hierarchy)
    ("ö" nil))

  (evil-leader/set-key
    "ö" 'hydra-rtags-navigation/body
    "." (lambda ()
          (interactive)
          (iflipb-next-buffer nil)
          (hydra-buffer-switch/body))))


;;;; Popwin
(use-package popwin
  :demand t
  :defines popwin:keymap
  :config
  (popwin-mode)
  (global-set-key (kbd "C-c w") popwin:keymap)
  (add-to-list 'popwin:special-display-config '("*RTags*" :stick t :noselect t :position bottom :width 60))
  (add-to-list 'popwin:special-display-config '("*Flycheck errors*" :noselect t)))

(provide 'init-window)
