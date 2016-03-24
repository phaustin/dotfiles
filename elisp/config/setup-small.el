
(use-package filladapt
  :load-path "~/repos/dotfiles/elisp"
  :config (setq-default filladapt-mode t))

(use-package highlight-region
  :load-path "~/repos/dotfiles/elisp")

(use-package plocal
  :load-path "~/repos/dotfiles/elisp")

(use-package dired-narrow
  :ensure t
  :bind (:map dired-mode-map
              ("/" . dired-narrow)))

(use-package visual-fill-column
  :ensure t
  :config
  ;;https://www.emacswiki.org/emacs/VisualLineMode
  (setq-default fill-column 100)
  (setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow)) 
  (add-hook 'minibuffer-setup-hook (lambda () (visual-line-mode -1)))
  (add-hook 'text-mode-hook 'turn-on-visual-line-mode)
  (add-hook 'text-mode-hook 'visual-fill-column-mode)) 

(use-package browse-kill-ring
  :ensure t
  :config (global-set-key (kbd "C-x C-y") `browse-kill-ring))

(use-package highlight-chars
  :ensure t
  :config
  (add-hook 'font-lock-mode-hook 'hc-highlight-tabs))

(use-package browse-url
  :config
  (setq browse-url-browser-function 'browse-url-firefox)
  (global-set-key "\C-xw" browse-url-browser-function))

(use-package gist
  :ensure t)

(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-x g") 'magit-status))

;;http://emacs.stackexchange.com/questions/10065/how-can-i-defer-loading-elpy-using-use-package

(use-package elpy
  :ensure t
  :init (with-eval-after-load 'python (elpy-enable))      
  :commands elpy-enable
  :config
  (setq elpy-rpc-backend "jedi")
  ;; (progn
  ;;   (setq elpy-rpc-backend "jedi"
  ;;         elpy-rpc-project-specific 't)
  ;;   (when (fboundp 'flycheck-mode)
  ;;     (setq elpy-modules (delete 'elpy-module-flymake elpy-modules))))
  (setq elpy-interactive-python-command "~phil/mini35/bin/ipython")
  (setq elpy-rpc-python-command "~phil/mini35/bin/python")
  (setq python-shell-interpreter "~phil/mini35/bin/ipython")
  (setq python-check-command (expand-file-name "~phil/mini35/bin/pyflakes"))
  (elpy-use-ipython "~phil/mini35/bin/ipython"))

(use-package yasnippet
  :ensure t
  :config
  (setq yas-triggers-in-field t)
  (setq yas-snippet-dirs
        '("~/repos/snippets"
          yas-installed-snippets-dir))
  (yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.
                                        ;http://orgmode.org/manual/Conflicts.html
  (add-hook 'org-mode-hook
            (lambda ()
              (org-set-local 'yas/trigger-key [tab])
              (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand))))

(use-package org-crypt
  :config
  (org-crypt-use-before-save-magic)
  ;; GPG key to use for encryption
  ;; Either the Key ID or set to nil to use symmetric encryption.
  (setq org-crypt-key nil))

(use-package eldoro
  :ensure t)

(use-package auto-package-update
  :ensure t)

;; https://github.com/rranelli/auto-package-update.el
;; (auto-package-update-maybe)
;; (auto-package-update-now)


;;https://github.com/jhelwig/ack-and-a-half
;;http://beyondgrep.com/
;;curl http://beyondgrep.com/ack-2.10-single-file > ~/bin/ack && chmod 0755 !#:3
;;(add-to-list 'load-path "/path/to/ack-and-a-half")

(use-package ack-and-a-half
  :ensure t
  :config
  ;; Create shorter aliases
  (defalias 'ack 'ack-and-a-half)
  (defalias 'ack-same 'ack-and-a-half-same)
  (defalias 'ack-find-file 'ack-and-a-half-find-file)
  (defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)
  (setq ack-and-a-half-executable "~/bin/ack"))

;;https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "PYTHONPATH")
    (exec-path-from-shell-copy-env "e340")
    (exec-path-from-shell-copy-env "e340f")
    (exec-path-from-shell-copy-env "or")
    (exec-path-from-shell-copy-env "rm")
    ))

