                                        ;##################
                                        ; mu4e
                                        ;#################


(use-package mu4e
  :load-path "/usr/local/Cellar/mu/HEAD/share/emacs/site-lisp/mu4e")

(setq mu4e-mu-binary "/usr/local/bin/mu")

(require `org-mu4e)

;;https://gist.github.com/chlalanne/7397629
(use-package offlineimap
  :ensure t)

(use-package mu4e-maildirs-extension
  :ensure t
  :config
  (mu4e-maildirs-extension))

(setq mu4e-maildir (expand-file-name "~/maildir"))

(setq mu4e-maildir-shortcuts
      '(("/eos/INBOX"          . ?i)
        ("/eos/Sent"           . ?s)
        ("/eos/Trash"          . ?t)
        ("/eos/Drafts"         . ?d)
        ("/eos/A405"           . ?4)
        ("/eos/A2016-01"       . ?r)
        ("/eos/A2015-12"       . ?b)
        ("/ubc/INBOX"          . ?u)))

(add-to-list 'mu4e-bookmarks '("flag:attach"    "Messages with attachment"   ?a) t)
(add-to-list 'mu4e-bookmarks '("size:5M..500M"  "Big messages"               ?b) t)
(add-to-list 'mu4e-bookmarks '("flag:flagged"   "Flagged messages"           ?f) t)

(setq mu4e-headers-date-format "%Y-%m-%d %H:%M:%S"
      mu4e-headers-fields '((:date . 20)
                            (:flags . 5)
                            (:maildir . 20)
                            (:from-or-to . 25)
                            (:subject . nil))) 
                                        ;-----------------------
                                        ; set up default account
                                        ;-----------------------
(use-package smtpmail
  :ensure t)


(setq message-kill-buffer-on-exit t
      mu4e-sent-messages-behavior 'sent
      mu4e-headers-include-related t
      mail-user-agent 'mu4e-user-agent
      mu4e-get-mail-command "offlineimap"
      mu4e-attachment-dir  "~/Downloads"
      smtpmail-queue-mail  nil
      smtpmail-queue-dir   "~/maildir/queue/cur")

                                        ;http://pragmaticemacs.com/emacs/master-your-inbox-with-mu4e-and-org-mode/
;;store link to message if in header view, not to header query
(setq org-mu4e-link-query-in-headers-mode nil)

(setq mu4e-sent-folder "/eos/INBOX"
      mu4e-drafts-folder "/eos/Drafts"
      mu4e-trash-folder "/eos/Trash"
      mu4e-refile-folder "/eos/A2016-01"
      mu4e-reply-to-address "paustin@eos.ubc.ca"
      user-mail-address "paustin@eos.ubc.ca"
      message-send-mail-function 'smtpmail-send-it
      smtpmail-auth-credentials
      (expand-file-name "~/.authinfo.gpg")
      smtpmail-default-smtp-server "smtp.googlemail.com"
      smtpmail-smtp-server "smtp.googlemail.com"
      user-full-name "Phil Austin"
      message-signature "best, Phil"
      message-citation-line-format "On %Y-%m-%d %H:%M:%S, %f wrote:"
      message-citation-line-function 'message-insert-formatted-citation-line
      mu4e-headers-results-limit 250
      smtpmail-smtp-service 465
      starttls-use-gnutls t
      smtpmail-stream-type 'tls
                                        ;starttls-gnutls-program "gnutls-cli"
                                        ;tls-program '("openssl s_client -ssl2 -connect %h:%p")
                                        ;starttls-extra-arguments '("--tofu")
                                        ;tls-program '("gnutls-cli --tofu --insecure -p %p %h")
      smtpmail-debug-info
      smtpmail-debug-verb)

                                        ;http://www.djcbsoftware.nl/code/mu/mu4e/Multiple-accounts.html
(defvar my-mu4e-account-alist
  '(("eos"
     (user-mail-address  "paustin@eos.ubc.ca")
     (user-full-name     "Phil Austin")
     (mu4e-sent-folder   "/eos/INBOX")
     (mu4e-drafts-folder "/eos/Drafts")
     (mu4e-trash-folder  "/eos/Trash")
     (mu4e-refile-folder "/eos/A2016-01"))
    ("ubc"
     (user-mail-address  "austin@mail.ubc.ca")
     (mu4e-sent-folder   "/ubc/INBOX")
     (mu4e-refile-folder "/eos/A2016-01")
     (mu4e-drafts-folder "/ubc/Drafts")
     (mu4e-trash-folder  "/ubc/Trash")
     (smtpmail-default-smtp-server "smtp.mail.ubc.ca")
     (smtpmail-smtp-server "smtp.mail.ubc.ca"))))

(setq mu4e-user-mail-address-list
      (mapcar (lambda (account) (cadr (assq 'user-mail-address account)))
              my-mu4e-account-alist))

(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var))
                                                my-mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                             nil t nil nil (caar my-mu4e-account-alist))))
         (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
              account-vars)
      (error "No email account found"))))


;;https://postmomentum.ch/steckemacs.html

(use-package quelpa
  :ensure t)

(if (require 'quelpa nil t)
    (quelpa '(quelpa :repo "quelpa/quelpa" :fetcher github) :upgrade t)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
    (eval-buffer)))
(quelpa '(key-chord :fetcher wiki))
(key-chord-mode 1)
(setq key-chord-two-keys-delay 0.03)
(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)
(setq mu4e-action-tags-header "X-Keywords")
(key-chord-define-global "nm" 'mu4e)
(mu4e)

                                        ;http://hack.org/mc/blog/mu4e.html
(setq mu4e-headers-skip-duplicates t)
(add-to-list 'mu4e-bookmarks
             '("maildir:/eos/INBOX flag:flagged OR maildir:/eos/INBOX flag:unread" "Unread or flagged in eos INBOX" ?h))
(add-to-list 'mu4e-bookmarks
             '("maildir:/eos/Trash" "Trash" ?t))
(setq mu4e-view-show-addresses t)

                                        ;http://www.emacswiki.org/emacs/BetterRegisters
                                        ;(require 'better-registers)

(add-to-list 'mu4e-view-actions
             '("ViewInBrowser" . mu4e-action-view-in-browser) t)

(setq mu4e-org-contacts-file  "/Users/phil/repos/org/contacts.org")
(add-to-list 'mu4e-headers-actions
             '("org-contact-add" . mu4e-action-add-org-contact) t)
(add-to-list 'mu4e-view-actions
             '("org-contact-add" . mu4e-action-add-org-contact) t)




