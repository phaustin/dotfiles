;; (use-package osx-browse
;;   :ensure t
;;   :config
;;   (osx-browse-mode 1)
;;   (global-set-key "\C-xw" 'browse))

(setq-default ispell-program-name "/usr/bin/ispell")

;; (setq exec-path
;;       '(
;;         "/usr/local/texlive/2015/bin/x86_64-darwin"
;;         "/Users/phil/bin"
;;         "/usr/local/bin"
;;         "/usr/bin"
;;         "/bin"
;;         "/usr/sbin"
;;         "/Users/phil/.local/bin"
;;         ))

;; (getenv "PATH")
;; (setenv "PATH"
;;         (concat
;;          "/usr/local/texlive/2015/bin/x86_64-darwin" ":"
;;          "/usr/local/bin" ":"
;;          (getenv "PATH")))


;; http://emacs.stackexchange.com/questions/10900/copy-text-from-emacs-to-os-x-clipboard
;; (defun copy-from-osx ()
;;   (shell-command-to-string "/usr/bin/pbpaste"))

;; (defun paste-to-osx (text &optional push)
;;   (let ((process-connection-type nil))
;;     (let ((proc (start-process "/usr/bin/pbcopy" "*Messages*" "pbcopy")))
;;       (process-send-string proc text)
;;       (process-send-eof proc))))

;; (setq interprogram-cut-function 'paste-to-osx)
;; (setq interprogram-paste-function 'copy-from-osx)
;; 


