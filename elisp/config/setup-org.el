(use-package org
  :ensure t
  :config
  (setq-default org-return-follows-link t)
  (setq org-agenada-start-day "-2d")
  (setq org-agenda-span 10)
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/repos/org/refile.org" "Tasks")
           "* TODO %?    \n  %i\n  %a")
          ("n" "Note" entry  (file+headline "~/repos/org/refile.org" "Notes")
           "* %?   :NOTE: \n  %i\n  %a")))
  (setq org-agenda-custom-commands
        '(("p" "Project List"
           ( (tags "PROJECT")
             )
           )
          ("w" tags-todo "WAITING" nil) 
          ("f" todo "FILED" nil) 
          ("n" todo "NEXT" nil)
          ("o" tags "NOTE" nil)
          ("d" "Agenda + Next Actions" ((agenda) (todo "NEXT")))
          ("O" "Office"
           ( (agenda)
             (tags-todo "OFFICE")
             )
           )
          ("W" "Weekly Plan"
           ( (agenda)
             (todo "TODO")
             (tags "PROJECT")
             )
           )
          ("H" "Home Lists"
           ( (agenda)
             (tags-todo "HOME")
             (tags-todo "COMPUTER")))))
  (setq org-mobile-directory "~/orgtransfer")
  (setq org-mobile-inbox-for-pull "~/repos/org/from-mobile.org")
  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (setq org-log-done t)
  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-ca" 'org-agenda)
  (setq org-return-follows-link t)
  (setq org-tags-exclude-from-inheritance '("PROJECT" "WAITING" "crypt"))
  (setq org-return-follows-link t)
  (setq org-agenda-files '("~/repos/org/refile.org" "~/repos/org/personal.org" "~/repos/org/tasks.org"
                           "~/repos/org/teaching.org" "~/repos/org/admin.org" "~/repos/org/research.org"))
  (setq org-todo-keywords
        (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))
  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "red" :weight bold)
                ("NEXT" :foreground "blue" :weight bold)
                ("DONE" :foreground "forest green" :weight bold)
                ("WAITING" :foreground "orange" :weight bold)
                ("HOLD" :foreground "magenta" :weight bold)
                ("CANCELLED" :foreground "forest green" :weight bold)
                ("MEETING" :foreground "forest green" :weight bold)
                ("PHONE" :foreground "forest green" :weight bold))))
  (setq org-use-fast-todo-selection t)
  (setq org-treat-S-cursor-todo-selection-as-state-change nil)
  (setq org-todo-state-tags-triggers
        (quote (("CANCELLED" ("CANCELLED" . t))
                ("WAITING" ("WAITING" . t))
                ("HOLD" ("WAITING" . t) ("HOLD" . t))
                (done ("WAITING") ("HOLD"))
                ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
                ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
                ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))
  (setq org-directory "~/repos/org")
  (setq org-default-notes-file "~/repos/org/refile.org")
  (global-set-key (kbd "C-c c") 'org-capture)
  (setq org-use-property-inheritance '("PRIORITY"))
                                        ; Targets include this file and any file contributing to the agenda - up to 9 levels deep
  (setq org-refile-targets (quote ((nil :maxlevel . 1)
                                   (org-agenda-files :maxlevel . 1))))
                                        ; Allow refile to create parent tasks with confirmation
  (setq org-refile-allow-creating-parent-nodes (quote confirm))

  (setq org-indirect-buffer-display 'current-window)

     ;;;; Refile settings
                                        ; Exclude DONE state tasks from refile targets
  (defun bh/verify-refile-target ()
    "Exclude todo keywords with a done state from refile targets"
    (not (member (nth 2 (org-heading-components)) org-done-keywords)))
  (setq org-refile-target-verify-function 'bh/verify-refile-target)
  (setq org-agenda-start-day "-2d")
  (setq org-agenda-span 10)

  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/repos/org/refile.org" "Tasks")
           "* TODO [#C] %?    \n  %i\n  %a")
          ("n" "Note" entry  (file+headline "~/repos/org/refile.org" "Notes")
           "* %?   :NOTE: \n  %i\n  %a")))
  
  (add-to-list 'org-capture-templates
               '("c" "Contacts" entry (file "~/repos/org/contacts.org")
                 "* %(org-contacts-template-name)
  :PROPERTIES:
  :EMAIL: %(org-contacts-template-email)
  :END:"))

  (setq org-agenda-include-diary t)
  (setq org-agenda-diary-file "~/repos/org/diary.org")
  ;;some unrelated customizations I made at the time (since I want the agenda front and center when I'm looking at it):
  (setq org-agenda-window-setup 'reorganize-frame)
  (setq org-agenda-restore-windows-after-quit t)
  (setq org-agenda-window-frame-fractions '(1.0 . 1.0))
  (setq org-use-property-inheritance '("PRIORITY"))
  ;;set priority range from A to D with default D
  (setq org-highest-priority ?A)
  (setq org-lowest-priority ?D)
  (setq org-default-priority ?D)
  ;;set colours for priorities
  (setq org-priority-faces '((?A . (:foreground "Red" :weight bold))
                             (?B . (:foreground "LightSteelBlue"))
                             (?C . (:foreground "OliveDrab"))))
  )

(use-package org-contacts
  :load-path "~/repos/org-mode/contrib/lisp/"
  :config
  (setq org-contacts-files '("~/repos/org/contacts.org")))

(use-package org-journal
  :ensure t        
  :config
                                        ;order is important to set org-mode correctly
  (setq org-journal-dir "~/repos/org/journal/")
  (global-set-key (kbd "C-c j") 'org-journal-new-entry)
  (global-set-key (kbd "C-c b") 'org-journal-open-previous-entry)
  (global-set-key (kbd "C-c f") 'org-journal-open-next-entry))

(use-package org-toodledo
  :ensure t
  :config
  (setq org-toodledo-file "/Users/phil/test.org")
  (setq org-toodledo-userid "td5693fec5543b6 ")
  (setq org-toodledo-password "fdLfums!"))

