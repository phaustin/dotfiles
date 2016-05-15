(require 'package)
(setq package-enable-at-startup nil)
;; marmalade needed for eldoro
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;;melpa needed for use-package
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
;;(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))
;;http://pragmaticemacs.com/emacs/double-dired-with-sunrise-commander/
(add-to-list 'package-archives
             '("SC" . "http://joseito.republika.pl/sunrise-commander/") t)
(package-initialize)

;;
;; needed for dirtrack prompt in .bashrc
;;
(setenv "EMACS" "TRUE")


;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;
; loop over config files and load
;
;https://github.com/krgn/mu4e-setup/blob/master/init.el
(setq relative-config-dir "~/repos/dotfiles/elisp/")
(setq setup-files-dir "config/")
(setq dot-files 
      (mapcar (lambda (item) (concat relative-config-dir setup-files-dir item))
           (list "setup-org.el"         ;org-mode
                 "setup-mu4e.el"        ;mu4e
                 "setup-auctex.el"
                 ;;filladapt, highlight-region, plocal, browse-kiil-ring, highlight-chars
                 ;;browse-url, gist, magit, elpy
                 "setup-sr.el"
                 "setup-small.el"
                 ;; os specific 
                 "setup-os.el"
                 )))
(dolist (file dot-files) (load-file file))

;end modernize

(select-keys) ; choose-a-buffer for keys f3 and f9-f12

(global-set-key [f9] 'python-mode)
(global-set-key [f8] 'org-mode)
(global-set-key [f7] 'fill-paragraph)
(global-set-key [f6] 'auto-fill-mode) 
(global-set-key [f5] 'visual-fill-column-mode) 
(global-set-key [f4] 'elpy-shell-switch-to-buffer) 
(global-set-key [f3] 'elpy-shell-switch-to-shell) 
(global-set-key [f2] 'choose-csh2) 
(global-set-key [f1] 'choose-csh1) 


(setq grep-command "grep -n -H -i ")


(defun choose-csh1 (&optional re-assign)
  "Set a key to a buffer"
  (interactive "P")
  (switch-to-buffer "csh1"))

(defun choose-csh2 (&optional re-assign)
  "Set a key to a buffer"
  (interactive "P")
  (switch-to-buffer "csh2"))

(defun choose-python (&optional re-assign)
  "Set a key to a buffer"
  (interactive "P")
  (switch-to-buffer "*ABI Ipython*"))


(defun choose-research (&optional re-assign)
  "Set a key to a buffer"
  (interactive "P")
  (switch-to-buffer "research.org"))


(defun choose-teaching (&optional re-assign)
  "Set a key to a buffer"
  (interactive "P")
  (switch-to-buffer "teaching.org"))

(defun choose-admin (&optional re-assign)
  "Set a key to a buffer"
  (interactive "P")
  (switch-to-buffer "admin.org"))

(defun choose-personal (&optional re-assign)
  "Set a key to a buffer"
  (interactive "P")
  (switch-to-buffer "personal.org"))

(defun choose-gtd (&optional re-assign)
  "Set a key to a buffer"
  (interactive "P")
  (switch-to-buffer "gtd.org"))

(defun choose-refile (&optional re-assign)
  "Set a key to a buffer"
  (interactive "P")
  (switch-to-buffer "refile.org"))


(make-shell "csh1")    ; Create a shell called "csh1"
(other-window 1)
(make-shell "csh2")    ; Create another shell in the other window

(put 'downcase-region 'disabled nil)

;######################


(defun gtd ()
   (interactive)
   (find-file "~/repos/org/gtd.org")
)


(defun research ()
   (interactive)
   (find-file "~/repos/org/research.org")
)

(defun refile ()
   (interactive)
   (find-file "~/repos/org/refile.org")
)


(defun teaching ()
   (interactive)
   (find-file "~/repos/org/teaching.org")
)

(defun admin ()
   (interactive)
   (find-file "~/repos/org/admin.org")
)


(defun personal ()
   (interactive)
   (find-file "~/repos/org/personal.org")
)

(defun tasks ()
  (interactive)
  (find-file "~/repos/org/tasks.org")
  )


;;(gtd)
(research)
(admin)
(teaching)
(personal)
(refile)
;(tasks)

(global-set-key "\C-cp" 'choose-personal)
(global-set-key "\C-cr" 'choose-research)
(global-set-key "\C-ci" 'choose-teaching)
(global-set-key "\C-cw" 'choose-admin)
(global-set-key "\C-cg" 'choose-gtd)
(global-set-key "\C-ct" 'choose-refile)

(key-chord-define-global "qw" 'eldoro)
;; (key-chord-define-global "--"
;;                          (lambda ()
;;                            "Insert an underscore"
;;                            (interactive)
;;                            (insert "_")))


(put 'dired-find-alternate-file 'disabled nil)


(defvar server-buffer-clients)
(when (and (fboundp 'server-start) (string-equal (getenv "TERM") 'xterm))
  (server-start)
  (defun fp-kill-server-with-buffer-routine ()
    (and server-buffer-clients (server-done)))
  (add-hook 'kill-buffer-hook 'fp-kill-server-with-buffer-routine))


(setenv "or" "~/repos/org")
(setenv "rm" "~/repos/readmes")

;;http://lists.gnu.org/archive/html/emacs-orgmode/2010-04/msg01057.html
;; 1. window gets split horizontally (one on TOP of the other), AND
;; 2. AFTER splitting, further "C-x 4 b" will NOT lead to any more splitting - reuse gets preferred
(setq split-height-threshold 40) ; nil
(setq split-width-threshold nil) ; 100


;http://www.emacswiki.org/emacs/FrameSize
(add-to-list 'default-frame-alist '(height . 55))
(add-to-list 'default-frame-alist '(width . 180))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;(setq inhibit-startup-screen t)
;(setq initial-major-mode 'org-mode)
(require 'magit)

;; (require 'ein-loaddefs)
;; (eval-when-compile (require 'ein-notebooklist))
;; (require 'ein)

;http://tex.stackexchange.com/questions/24510/pdflatex-fails-within-emacs-app-but-works-in-terminal
;http://ergoemacs.org/emacs/emacs_env_var_paths.html


(setq-default indent-tabs-mode nil)

(load-theme 'adwaita t)

;; (use-package zenburn-theme
;;   :ensure t
;;   :config
;;   (load-theme 'zenburn t))

;; (use-package anti-zenburn-theme
;;   :ensure t
;;   :config
;;   (load-theme 'anti-zenburn t))


(defun markdown-preview-file ()
  "use Marked 2 to preview the current file"
  (interactive)
  (shell-command 
   (format "open -a 'Marked 2.app' %s" 
           (shell-quote-argument (buffer-file-name))))
  )
(global-set-key "\C-cm" 'markdown-preview-file)

;;https://www.emacswiki.org/emacs/FlySpell
(dolist (hook '(rst-mode-hook))
      (add-hook hook (lambda () (flyspell-mode 1))))
      
(autoload 'vkill "vkill" nil t)
(autoload 'list-unix-processes "vkill" nil t)


(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(setq org-ellipsis "⤵")
(show-paren-mode 1)


(server-start)

(setq auto-mode-alist (cons '("\\.txt\\'" . text-mode) auto-mode-alist))

;;http://emacsredux.com/blog/2016/02/07/auto-indent-your-code-with-aggressive-indent-mode/

;;(global-aggressive-indent-mode 1)
;;(add-to-list 'aggressive-indent-excluded-modes 'html-mode)


(setq fill-column 120)

;(setq split-width-threshold nil)
(setq split-width-threshold 1 )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (company toml-mode anti-zenburn-theme zenburn-theme yaml-mode websocket visual-fill-column use-package tide stan-mode spotlight sphinx-frontend sphinx-doc smartrep rtags quelpa python-info py-yapf ox-rst osx-browse org-toodledo org-journal org-gcal offlineimap nose multi-eshell mu4e-maildirs-extension mic-paren markdown-mode+ magit key-chord julia-shell jedi-direx idomenu highlight-parentheses highlight-chars flymake exec-path-from-shell ess elpy eldoro dired-narrow cython-mode cmake-ide browse-kill-ring better-registers auto-package-update auto-complete-rst auctex-latexmk aggressive-indent ack-and-a-half ace-jump-mode 4clojure))))
(put 'upcase-region 'disabled nil)

