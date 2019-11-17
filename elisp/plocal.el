;; These are a bunch of emacs lisp routines used locally in the
;; geography department to set up keybindings and the like

;;https://stackoverflow.com/questions/6997387/how-to-archive-all-the-done-tasks-using-a-single-command
(defun pha/org-archive-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (outline-previous-heading)))
   "/DONE" 'tree))

;; Functions to create shells

;; make-shell:
;;
;; Creates a shell with the given name
;; starts the new directory tracking if available, and
;; makes it difficult to kill.

(defun nowrap_buffer ()
  (interactive)
  (set-fill-column 300)
  (toggle-truncate-lines)
)



(defun make-shell (name)
  "Start a new shell and rename the buffer NAME"
  (shell)
  (if (boundp 'shell-newdirtrackp)
      (shell-newdirtrack-toggle))
  (rename-buffer name)
  (make-local-variable 'kill-buffer-hook)
  (add-hook 'kill-buffer-hook 
            '(lambda ()
               (if (not (yes-or-no-p 
                         "Last chance not to kill a SHELL buffer: Kill it? "))
                   (keyboard-quit)))))

;; ask-shell:
;;
;; Prompt the user for a name of a new shell
;; then call make-shell

(defun ask-shell ()
  "Creates a new shell, and asks the user for the buffer name"
  (interactive)
  (let ((dscpt (read-string "name: ")))
  (make-shell dscpt)))

;; sun-keypad:
;;
;; Map the sun function keys/keypad to their names
;; so they can be bound easier.

;; xterm-keypad
;;
;; Set up the keypad on the xterms

(defun xterm-keypad ()
  "Define bindings for NCD xterm keypads"
  (interactive)
  (global-set-key [kp-7] 'backward-page)
  (global-set-key [kp-1] 'forward-page)
  (global-set-key [kp-3] 'scroll-up)
  (global-set-key [kp-9] 'scroll-down)
  (global-set-key [kp-8] 'previous-line)
  (global-set-key [kp-2] 'next-line)
  (global-set-key [kp-4] 'backward-char)
  (global-set-key [kp-6] 'forward-char))

;; Following code allows you to assign a buffer/string/macro to
;; a key dynamically. (i.e. first time the key is pressed it will
;; ask for a buffer (or string/macro), after that pressing the 
;; key will switch you to that buffer (or insert the string, run 
;; the macro)

(defvar stored-key-info nil)

;; preset-a-*
;;
;; Allow a key to be pre-set to a buffer/string/macro
;; useful in a .emacs file:
;; (preset-a-buffer 'f1 "csh1")

(defun preset-a-buffer (key buffer)
  "Preset a key to a buffer"
  (setq stored-key-info (cons (cons key (get-buffer buffer)) stored-key-info)))

(defun preset-a-string (key string)
  "Preset a key to a string"
  (setq stored-key-info (cons (cons key string) stored-key-info)))

(defun preset-a-macro (key macro)
  "Preset a key to a buffer"
  (setq stored-key-info (cons (cons key macro) stored-key-info)))

;; re-choose-a-*
;;
;; Allow a previously set key to be reassigned

(defun re-choose-a-buffer ()
  "Re-set a key to a buffer"
  (interactive)
  (choose-a-buffer 1))

(defun re-choose-a-macro ()
  "Re-set a key to a macro"
  (interactive)
  (choose-a-macro 1))

(defun re-choose-a-string ()
  "Re-set a key to a string"
  (interactive)
  (choose-a-string 1))

;; choose-a-*
;;
;; If a key has an assigned value (buffer/string/macro) then
;; do the appropriate action (switch to the buffer, insert the
;; string, run the macro).  If the key is unassigned then prompt
;; for a new value (buffer/string/macro)

(defun choose-a-buffer (&optional re-assign)
  "Set a key to a buffer (Prefix re-assign)"
  (interactive "P")
  (let* ((key last-command-event)
         (buf-assoc (assoc key stored-key-info))
         (buffer (cdr buf-assoc)))
    
    ;; if buffer is set to something but its deleted
    ;; or we want to reassign it...
    (if (and buffer 
             (or re-assign (not (buffer-name buffer))))
        (progn
          (setq stored-key-info (delq buf-assoc stored-key-info))
          (setq buffer nil)))

    ;; if buffer is not set then set it
    (if (not buffer)
        (progn
          (setq buffer (get-buffer (read-buffer "Buffer for key? " (current-buffer) t)))
          (setq stored-key-info (cons (cons key buffer) stored-key-info))))
    
    ;; switch to the new buffer
    ;(switch-to-buffer buffer)
))

(defun choose-a-string (&optional re-assign)
  "Set a key to a string (Prefix re-assign)"
  (interactive "P")
  (let* ((key last-command-event)
         (string-assoc (assoc key stored-key-info))
         (string (cdr string-assoc)))
    
    ;; if buffer is set to something and we want to reassign it
    (if (and string re-assign )
        (progn
          (setq stored-key-info (delq string-assoc stored-key-info))
          (setq string nil)))

    ;; if string is not set then set it
    (if (not string)
        (progn
          (setq string (read-from-minibuffer "String for key? "))
          (setq stored-key-info (cons (cons key string) stored-key-info))))
    
    ;; insert the string into current buffer
    (insert string)))

(defun choose-a-macro (&optional re-assign)
  "Set a key to a macro (Prefix re-assign)"
  (interactive "P")
  (let* ((key last-command-event)
         (macro-assoc (assoc key stored-key-info))
         (macro (cdr macro-assoc)))
    
    ;; if buffer is set to something and we want to reassign it
    (if (and macro re-assign )
        (progn
          (setq stored-key-info (delq macro-assoc stored-key-info))
          (setq macro nil)))

    ;; if string is not set then set it
    (if (not macro)
        (progn
          (setq macro (read-command "Macro for key? "))
          (setq stored-key-info (cons (cons key macro) stored-key-info))))
    
    ;; execute the macro
    (execute-kbd-macro macro)))

(defvar stored-key-info nil)

;; preset-a-*
;;
;; Allow a key to be pre-set to a buffer/string/macro
;; useful in a .emacs file:
;; (preset-a-buffer 'f1 "csh1")

(defun preset-a-buffer (key buffer)
  "Preset a key to a buffer"
  (setq stored-key-info (cons (cons key (get-buffer buffer)) stored-key-info)))

(defun preset-a-string (key string)
  "Preset a key to a string"
  (setq stored-key-info (cons (cons key string) stored-key-info)))

(defun preset-a-macro (key macro)
  "Preset a key to a buffer"
  (setq stored-key-info (cons (cons key macro) stored-key-info)))

;; choose-a-*
;;
;; If a key has an assigned value (buffer/string/macro) then
;; do the appropriate action (switch to the buffer, insert the
;; string, run the macro).  If the key is unassigned then prompt
;; for a new value (buffer/string/macro)

(defun choose-a-buffer (&optional re-assign)
  "Set a key to a buffer (Prefix re-assign)"
  (interactive "P")
  (let* ((key last-command-event)
         (buf-assoc (assoc key stored-key-info))
         (buffer (cdr buf-assoc)))
    
    ;; if buffer is set to something but its deleted
    ;; or we want to reassign it...
    (if (and buffer 
             (or re-assign (not (buffer-name buffer))))
        (progn
          (setq stored-key-info (delq buf-assoc stored-key-info))
          (setq buffer nil)))

    ;; if buffer is not set then set it
    (if (not buffer)
        (progn
          (setq buffer (get-buffer (read-buffer "Buffer for key? " (current-buffer) t)))
          (setq stored-key-info (cons (cons key buffer) stored-key-info))))
    
    ;; switch to the new buffer
    (switch-to-buffer buffer)))

(defun choose-a-string (&optional re-assign)
  "Set a key to a string (Prefix re-assign)"
  (interactive "P")
  (let* ((key last-command-event)
         (string-assoc (assoc key stored-key-info))
         (string (cdr string-assoc)))
    
    ;; if buffer is set to something and we want to reassign it
    (if (and string re-assign )
        (progn
          (setq stored-key-info (delq string-assoc stored-key-info))
          (setq string nil)))

    ;; if string is not set then set it
    (if (not string)
        (progn
          (setq string (read-from-minibuffer "String for key? "))
          (setq stored-key-info (cons (cons key string) stored-key-info))))
    
    ;; insert the string into current buffer
    (insert string)))

(defun choose-a-macro (&optional re-assign)
  "Set a key to a macro (Prefix re-assign)"
  (interactive "P")
  (let* ((key last-command-event)
         (macro-assoc (assoc key stored-key-info))
         (macro (cdr macro-assoc)))
    
    ;; if buffer is set to something and we want to reassign it
    (if (and macro re-assign )
        (progn
          (setq stored-key-info (delq macro-assoc stored-key-info))
          (setq macro nil)))

    ;; if string is not set then set it
    (if (not macro)
        (progn
          (setq macro (read-command "Macro for key? "))
          (setq stored-key-info (cons (cons key macro) stored-key-info))))
    
    ;; execute the macro
    (execute-kbd-macro macro)))


;from: http://trey-jackson.blogspot.com/2008/08/emacs-tip-25-shell-dirtrack-by-prompt.html
(add-hook 'shell-mode-hook
        #'(lambda ()
            (shell-dirtrack-mode nil)
            (add-hook 'comint-preoutput-filter-functions
                      'shell-sync-dir-with-prompt nil t)))

(defun shell-sync-dir-with-prompt (string)
"A preoutput filter function (see `comint-preoutput-filter-functions')
which sets the shell buffer's path to the path embedded in a prompt string.
This is a more reliable way of keeping the shell buffer's path in sync
with the shell, without trying to pattern match against all
potential directory-changing commands, ala `shell-dirtrack-mode'.

In order to work, your shell must be configured to embed its current
working directory into the prompt.  Here is an example .zshrc and .bashrc
snippet which turns this behavior on when running as an inferior Emacs shell:

zsh

  if [ $EMACS ]; then
     prompt='|Pr0mPT|%~|[%n@%m]%~%# '
string  fi

The part that Emacs cares about is the '|Pr0mPT|%~|'
Everything past that can be tailored to your liking.
"
(if (string-match "|Pr0mPT|\\([^|]*\\)|" string)
    (let ((cwd (match-string 1 string)))
      (setq default-directory
            (if (string-equal "/" (substring cwd -1))
                cwd
              (setq cwd (concat cwd "/"))))
      (replace-match "" t t string 0))
  string))


(provide 'plocal)


