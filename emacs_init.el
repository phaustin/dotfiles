;; require package
(require 'package)

;; add melpa stable
(add-to-list 'package-archives
         '("melpa-stable" . "https://stable.melpa.org/packages/"))

;; add melpa
;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.milkbox.net/packages/"))

(package-refresh-contents)

;; Initialise packages
;(package-initialize)

;; add use package
;;(package-install 'use-package)
;;
;; needed for dirtrack prompt in .bashrc
;;
(setenv "EMACS" "TRUE")
;; https://emacs.stackexchange.com/questions/74289/emacs-28-2-error-in-macos-ventura-image-type-invalid-image-type-svg
(setq image-types (cons 'svg image-types))
;; ;; Bootstrap `use-package'
;; (unless (package-installed-p 'use-package)
;;   (package-refresh-contents)
;;   (package-install 'use-package))
;
; loop over config files and load
;
(setq relative-config-dir "~/repos/dotfiles/elisp/")
(setq setup-files-dir "config/")
(setq dot-files 
      (mapcar (lambda (item) (concat relative-config-dir setup-files-dir item))
           (list "setup-org.el"         ;org-mode
                 "setup-auctex.el"
                 ;;filladapt, highlight-region, plocal, browse-kiil-ring, highlight-chars
                 ;;browse-url, gist, magit, elpy
                 "setup-small.el"
                 ;; os specific 
                 "setup-os.el"
                 )))
(dolist (file dot-files) (load-file file))

;end modernize



(setq grep-command "grep -n -H -i ")


(defun choose-csh1 (&optional re-assign)
  "Set a key to a buffer"
  (interactive "P")
  (switch-to-buffer "s1"))

(defun choose-csh2 (&optional re-assign)
  "Set a key to a buffer"
  (interactive "P")
  (switch-to-buffer "s2"))

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


(make-shell "s1")    ; Create a shell called "s1"
(other-window 1)
(make-shell "s2")    ; Create another shell in the other window

(put 'downcase-region 'disabled nil)

;; ;######################


(defun gtd ()
   (interactive)
   (find-file "~/Dropbox/phil_files/org/gtd.org")
)


(defun research ()
   (interactive)
   (find-file "~/Dropbox/phil_files/org/research.org")
)

(defun refile ()
   (interactive)
   (find-file "~/Dropbox/phil_files/org/refile.org")
)


(defun teaching ()
   (interactive)
   (find-file "~/Dropbox/phil_files/org/teaching.org")
)

(defun admin ()
   (interactive)
   (find-file "~/Dropbox/phil_files/org/admin.org")
)


(defun personal ()
   (interactive)
   (find-file "~/Dropbox/phil_files/org/personal.org")
)

(defun tasks ()
  (interactive)
  (find-file "~/Dropbox/phil_files/org/tasks.org")
  )


;;(gtd)
(research)
(admin)
(teaching)
;; (personal)
;; (refile)
;; (tasks)

(global-set-key "\C-cp" 'choose-personal)
(global-set-key "\C-cr" 'choose-research)
(global-set-key "\C-ci" 'choose-teaching)
(global-set-key "\C-cw" 'choose-admin)
(global-set-key "\C-cg" 'choose-gtd)
(global-set-key "\C-ct" 'choose-refile)

;; (key-chord-define-global "--"
;;                          (lambda ()
;;                            "Insert an underscore"
;;                            (interactive)
;;                            (insert "_")))


;; ;; (put 'dired-find-alternate-file 'disabled nil)


;; ;; (defvar server-buffer-clients)
;; ;; (when (and (fboundp 'server-start) (string-equal (getenv "TERM") 'xterm))
;; ;;   (server-start)
;; ;;   (defun fp-kill-server-with-buffer-routine ()
;; ;;     (and server-buffer-clients (server-done)))
;; ;;   (add-hook 'kill-buffer-hook 'fp-kill-server-with-buffer-routine))

;; ;; (setq dired-use-ls-dired nil)


;; ;; ;; don't split windows
;; ;; ;;http://lists.gnu.org/archive/html/emacs-orgmode/2010-04/msg01057.html
;; ;; ;; 1. window gets split horizontally (one on TOP of the other), AND
;; ;; ;; 2. AFTER splitting, further "C-x 4 b" will NOT lead to any more splitting - reuse gets preferred
;; ;; ;; (setq split-height-threshold 2000) ; nil
;; ;; ;; (setq split-width-threshold 2000) ; 100


;; ;; ;;https://stackoverflow.com/questions/23207958/how-to-prevent-emacs-dired-from-splitting-frame-into-more-than-two-windows
;; ;; (setq split-width-threshold (- (window-width) 10))
;; ;; (setq split-height-threshold nil)

;; ;; (defun count-visible-buffers (&optional frame)
;; ;;   "Count how many buffers are currently being shown. Defaults to selected frame."
;; ;;   (length (mapcar #'window-buffer (window-list frame))))

;; ;; (defun do-not-split-more-than-two-windows (window &optional horizontal)
;; ;;   (if (and horizontal (> (count-visible-buffers) 1))
;; ;;       nil
;; ;;     t))

;; ;; (advice-add 'window-splittable-p :before-while #'do-not-split-more-than-two-windows)


;; ;; ;http://www.emacswiki.org/emacs/FrameSize
;; ;; (add-to-list 'default-frame-alist '(height . 55))
;; ;; (add-to-list 'default-frame-alist '(width . 180))
;; ;; (custom-set-faces
;; ;;  ;; custom-set-faces was added by Custom.
;; ;;  ;; If you edit it by hand, you could mess it up, so be careful.
;; ;;  ;; Your init file should contain only one such instance.
;; ;;  ;; If there is more than one, they won't work right.
;; ;;  )

;(setq inhibit-startup-screen t)
;(setq initial-major-mode 'org-mode)
(require 'magit)

;; ;; ;; (require 'ein-loaddefs)
;; ;; ;; (eval-when-compile (require 'ein-notebooklist))
;; ;; ;; (require 'ein)

;; ;; ;http://tex.stackexchange.com/questions/24510/pdflatex-fails-within-emacs-app-but-works-in-terminal
;; ;; ;http://ergoemacs.org/emacs/emacs_env_var_paths.html


(setq-default indent-tabs-mode nil)

(load-theme 'adwaita t)

;; ;; ;; (use-package zenburn-theme
;; ;; ;;   :ensure t
;; ;; ;;   :config
;; ;; ;;   (load-theme 'zenburn t))

;; ;; ;; (use-package anti-zenburn-theme
;; ;; ;;   :ensure t
;; ;; ;;   :config
;; ;; ;;   (load-theme 'anti-zenburn t))


;; ;; (defun markdown-preview-file ()
;; ;;   "use Marked 2 to preview the current file"
;; ;;   (interactive)
;; ;;   (shell-command 
;; ;;    (format "open -a 'Marked 2.app' %s" 
;; ;;            (shell-quote-argument (buffer-file-name))))
;; ;;   )
;; ;; (global-set-key "\C-cm" 'markdown-preview-file)

;; ;; ;;https://www.emacswiki.org/emacs/FlySpell
;; ;; ;; (dolist (hook '(rst-mode-hook))
;; ;; ;;       (add-hook hook (lambda () (flyspell-mode 1))))
      
;; ;; (autoload 'vkill "vkill" nil t)
;; ;; (autoload 'list-unix-processes "vkill" nil t)


;; ;; (autoload 'markdown-mode "markdown-mode"
;; ;;    "Major mode for editing Markdown files" t)
;; ;; (add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
;; ;; (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
;; ;; (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(setq org-ellipsis "⤵")
(show-paren-mode 1)


(server-start)

(setq auto-mode-alist (cons '("\\.txt\\'" . text-mode) auto-mode-alist))

;;http://emacsredux.com/blog/2016/02/07/auto-indent-your-code-with-aggressive-indent-mode/

;; ;; ;;(global-aggressive-indent-mode 1)
;; ;; ;;(add-to-list 'aggressive-indent-excluded-modes 'html-mode)

;; ;; ;(key-chord-define-global "qw" 'eldoro)
;; ;; (setq fill-column 120)

;; ;; ;(setq split-width-threshold nil)
;; ;; (setq split-width-threshold 1 )

;; ;; (custom-set-variables
;; ;;  ;; custom-set-variables was added by Custom.
;; ;;  ;; If you edit it by hand, you could mess it up, so be careful.
;; ;;  ;; Your init file should contain only one such instance.
;; ;;  ;; If there is more than one, they won't work right.
;; ;;  '(dired-listing-switches "-alh")
;; ;;  '(nil nil t)
;; ;;  '(package-selected-packages
;; ;;    '(corfu tempel zenburn-theme yaml-mode yagist web-mode visual-fill-column use-package toml-mode thingatpt+ simpleclip ripgrep rg pelican-mode pdf-tools ox-gfm orglink orgit org-toodledo org-journal org-gcal offlineimap mu4e-maildirs-extension mic-paren matlab-mode material-theme markdown-mode lorem-ipsum json-navigator json-mode indent-tools helm-descbinds grip-mode frame-cmds flymake-json flymake-jslint filladapt fill-column-indicator exec-path-from-shell elpy dired-single dired-narrow desktop+ cpputils-cmake cmake-mode browse-kill-ring bm auto-package-update auto-complete anti-zenburn-theme))
;; ;;  '(tempel-path "~/Dropbox/phil_files/emacs/snippets/*eld")
;; ;;  '(warning-suppress-types
;; ;;    '(((package reinitialization))
;; ;;      ((package reinitialization)))))
;; ;; ;(require 'better-defaults)
;; ;; ;(load-theme 'material t)


;; ;; ;http://mbork.pl/2017-02-26_other-window-or-switch-buffer
;; ;; (defun other-window-or-switch-buffer ()
;; ;;   "Call `other-window' if more than one window is visible, switch
;; ;; to next buffer otherwise."
;; ;;   (interactive)
;; ;;   (if (one-window-p)
;; ;; 	  (switch-to-buffer nil)
;; ;; 	(other-window 1)))

;; easy spell check
(global-set-key (kbd "C-<f8>") 'fill-paragraph)
(global-set-key (kbd "<f8>") 'ispell-word)
(global-set-key (kbd "C-S-<f8>") 'flyspell-mode)
(global-set-key (kbd "C-M-<f8>") 'flyspell-buffer)
(global-set-key (kbd "C-<f8>") 'flyspell-check-previous-highlighted-word)
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
  (flyspell-goto-next-error)
  (ispell-word)
  )
(global-set-key (kbd "M-<f8>") 'flyspell-check-next-highlighted-word)

(add-to-list 'tramp-default-proxies-alist
                 '("azure" nil "/ssh:compstaff@52.233.66.236:"))

(setq tramp-default-method "ssh")

;https://www.masteringemacs.org/article/evaluating-elisp-emacs

;; ;; (require 'auto-complete)
;; ;; (add-hook 'emacs-lisp-mode-hook 'ielm-auto-complete)

;; ;; (defun ielm-auto-complete ()
;; ;;   "Enables `auto-complete' support in \\[ielm]."
;; ;;   (setq ac-sources '(ac-source-functions
;; ;;                      ac-source-variables
;; ;;                      ac-source-features
;; ;;                      ac-source-symbols
;; ;;                      ac-source-words-in-same-mode-buffers))
;; ;;   (add-to-list 'ac-modes 'inferior-emacs-lisp-mode)
;; ;;   (auto-complete-mode 1))
;; ;; (add-hook 'ielm-mode-hook 'ielm-auto-complete)

;; ;; (defun my-ielm-mode-defaults ()
;; ;;   (turn-on-eldoc-mode))

;; ;; (setq my-ielm-mode-hook 'my-ielm-mode-defaults)

;; ;; ;https://stackoverflow.com/questions/17118305/how-do-i-print-a-string-in-emacs-lisp-with-ielm
;; ;; (add-hook 'ielm-mode-hook (lambda () (run-hooks 'my-ielm-mode-hook)))

;; ;; (defun p (x) (move-end-of-line 0) (insert (format "\n%s" x)))

;; ;; (setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
;; ;;   backup-by-copying t    ; Don't delink hardlinks
;; ;;   version-control t      ; Use version numbers on backups
;; ;;   delete-old-versions t  ; Automatically delete excess backups
;; ;;   kept-new-versions 20   ; how many of the newest versions to keep
;; ;;   kept-old-versions 5    ; and how many of the old
;; ;;   )

;; ;; ;;https://github.com/purcell/flymake-json
;; ;; (add-hook 'json-mode-hook 'flymake-json-load)

;; ;; ;; (setq browse-url-browser-function 'browse-url-generic
;; ;; ;;       browse-url-generic-program "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/usr/bin/google-chrome")

(when (memq window-system '(mac ns))
   (setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"))


(global-set-key "\C-xw" 'browse-url)

;; ;; ;https://www.emacswiki.org/emacs/CuaMode
;; ;; ;; (cua-mode t)
;; ;; ;;     (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
;; ;; ;;     (transient-mark-mode 1) ;; No region when it is not highlighted
;; ;; ;;     (setq cua-keep-region-after-copy t) ;; Standard Windows behaviour


(require 'flyspell)
(setq ispell-program-name "/usr/bin/ispell")

(when (memq window-system '(mac ns))
  (setq ispell-program-name "/opt/homebrew/bin/aspell"))
(flyspell-mode +1)



(put 'upcase-region 'disabled nil)


(defun select-keys ()
  "Set up key bindings to allow assignment of buffers to function keys"
  (interactive)
  (global-set-key [f10] 'choose-a-buffer)
  (global-set-key [f11] 'choose-a-buffer)
  (global-set-key [f12] 'choose-a-buffer))

(select-keys) ; choose-a-buffer for keys f3 and f9-f12

(global-set-key [f8] 'org-mode)
(global-set-key [f7] 'org-toggle-link-display)
(global-set-key [f6] 'auto-fill-mode) 
(global-set-key (kbd "<f5>") #'deadgrep)
(global-set-key [f3] 'visual-fill-column-mode) 
(global-set-key [f2] 'choose-csh2) 
(global-set-key [f1] 'choose-csh1) 

(use-package bm
  :bind (("<C-f9>" . bm-toggle)
         ("<f9>" . bm-next)
         ("<S-f>" . bm-previous)))

;; https://github.com/dajva/rg.el

(require 'rg)
(rg-enable-default-bindings)

;; ;; (setq save-interprogram-paste-before-kill t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(yaml-mode visual-fill-column use-package tempel ripgrep rg ox-gfm osx-browse org-journal markdown-mode magit json-reformat json-navigator json-mode flymake-json filladapt exec-path-from-shell elpy dired-single desktop+ deadgrep corfu browse-kill-ring bm auto-package-update auto-complete auctex-latexmk)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq TeX-view-program-list `(("xpdf" "xpdf -fullscreen %o")))
(setq TeX-view-program-selection `((output-pdf "xpdf")))

(rg-enable-default-bindings)
