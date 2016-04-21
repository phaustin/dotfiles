;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; sunrise commander                                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;http://pragmaticemacs.com/emacs/resize-your-emacs-frame-with-keyboard-shortcuts/

(use-package frame-cmds
  :ensure t
)
;;set frame full height and 86 columns wide
;;and position at screen left
(defun bjm-frame-resize-l ()
  "set frame full height and 86 columns wide and position at screen left"
  (interactive)
  (set-frame-width (selected-frame) 86)
  (maximize-frame-vertically)
  (set-frame-position (selected-frame) 0 0)
  )

;;set frame full height and 86 columns wide
;;and position at screen right
(defun bjm-frame-resize-r ()
  "set frame full height and 86 columns wide and position at screen right"
  (interactive)
  (set-frame-width (selected-frame) 86)
  (maximize-frame-vertically)
  (set-frame-position (selected-frame) (- (display-pixel-width) (frame-pixel-width)) 0)
  )

;;set frame full height and 86 columns wide
;;and position at screen right of left hand screen in 2 monitor display
;;assumes monitors are same resolution
(defun bjm-frame-resize-r2 ()
  "set frame full height and 86 columns wide and position at screen right of left hand screen in 2 monitor display assumes monitors are same resolution"
  (interactive)
  (set-frame-width (selected-frame) 86)
  (maximize-frame-vertically)
  (set-frame-position (selected-frame) (- (/ (display-pixel-width) 2) (frame-pixel-width)) 0)
  )

;;set keybindings
;; (global-set-key (kbd "C-c b <left>") 'bjm-frame-resize-l)
;; (global-set-key (kbd "C-c b <right>") 'bjm-frame-resize-r)
;; (global-set-key (kbd "C-c b <S-right>") 'bjm-frame-resize-r2)

;;http://pragmaticemacs.com/emacs/double-dired-with-sunrise-commander/

(use-package sunrise-commander
  :ensure t
  :config
  ;; disable mouse
  (setq sr-cursor-follows-mouse nil)
  (define-key sr-mode-map [mouse-1] nil)
  (define-key sr-mode-map [mouse-movement] nil)

  ;;tweak faces for paths
  (set-face-attribute 'sr-active-path-face nil
                      :background "black")
  (set-face-attribute 'sr-passive-path-face nil
                      :background "black")

  ;;advise sunrise to save frame arrangement
  ;;requires frame-cmds package
  (defun bjm-sc-save-frame ()
    "Save frame configuration and then maximise frame for sunrise commander."
    (save-frame-config)
    (maximize-frame)
    )
  (advice-add 'sunrise :before #'bjm-sc-save-frame)

  (defun bjm-sc-restore-frame ()
    "Restore frame configuration saved prior to launching sunrise commander."
    (interactive)
    (jump-to-frame-config-register)
    )
  (advice-add 'sr-quit :after #'bjm-sc-restore-frame)
)

(use-package sunrise-x-buttons
  :ensure t
  )

(use-package sunrise-x-modeline
  :ensure t
  )
