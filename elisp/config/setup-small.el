;; (use-package quelpa
;;   :ensure t)

;; (if (require 'quelpa nil t)
;;     (quelpa '(quelpa :repo "quelpa/quelpa" :fetcher github) :upgrade t)
;;   (with-temp-buffer
;;     (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
;;     (eval-buffer)))

;(quelpa '(key-chord :fetcher wiki))
;(key-chord-mode 1)
;(setq key-chord-two-keys-delay 0.03)

(use-package filladapt
  :ensure t
  :config (setq-default filladapt-mode t))

(use-package dired-single
    :ensure t)

(use-package auto-complete
    :ensure t)

(use-package web-mode
  :config (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
         (setq web-mode-engines-alist
         '(("jinja"    . "\\.html\\'")))
  )


(use-package highlight-region
  :load-path "~/repos/dotfiles/elisp")

(use-package plocal
  :load-path "~/repos/dotfiles/elisp")

(use-package rst
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

(use-package mic-paren
  :ensure t)

(use-package desktop+
  :ensure t)

(use-package json-mode
  :ensure t)

(use-package json-navigator
  :ensure t)

(use-package json-reformat
  :ensure t)

(use-package yaml-mode
  :ensure t)

(use-package toml-mode
  :ensure t)

(use-package company
  :ensure t)


(use-package browse-kill-ring
  :ensure t
  :config (global-set-key (kbd "C-x C-y") `browse-kill-ring))


(use-package highlight-chars
  :load-path "~/repos/dotfiles/elisp"
  :config
  (add-hook 'font-lock-mode-hook 'hc-highlight-tabs)
  (hc-toggle-highlight-trailing-whitespace)) 


;; (use-package company
;;   :ensure t
;;   :config
;;   (add-hook 'after-init-hook 'global-company-mode))

;; (use-package gist
;;   :ensure t)

;; (use-package yagist
;;      :ensure t)


(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-x g") 'magit-status))


(use-package flymake-json
  :ensure t
  :config
  (add-hook 'json-mode-hook 'flymake-json-load))


;;http://emacs.stackexchange.com/questions/10065/how-can-i-defer-loading-elpy-using-use-package

(use-package elpy
  :ensure t
  :init (with-eval-after-load 'python (elpy-enable))
  :commands elpy-enable
  :config
  (setq elpy-rpc-backend "jedi")
  (setq elpy-rpc-timeout 5)
  (add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1)))
  ;; (progn
  ;;   (setq elpy-rpc-backend "jedi"
  ;;         elpy-rpc-project-specific 't)
  ;;   (when (fboundp 'flycheck-mode)
  ;;     (setq elpy-modules (delete 'elpy-module-flymake elpy-modules))))
  ;;(setq elpy-interactive-python-command "/Users/phil/bin/ipyelpy.sh")
  (setq conda_prefix (getenv "CONDA_PREFIX"))
  ;; (if conda_prefix nil
  ;;     (setq conda_prefix "/Users/phil/a50037/envs/a500try2"))
  (if conda_prefix nil
      (setq conda_prefix (getenv "CONDA_DEFAULT")))
  (setq python_path (format "%s/bin/python" conda_prefix))
  (setq ipython_path (format "%s/bin/ipython" conda_prefix))
  (setq pyflakes_path (format "%s/bin/pyflakes" conda_prefix))
  (setq python-shell-interpreter ipython_path
        python-shell-interpreter-args "--simple-prompt --matplotlib")
  (setq elpy-syntax-check-command (format "%s/bin/pyflakes" conda_prefix))
  (setq elpy-rpc-python-command python_path)
  (setq python-check-command (expand-file-name pyflakes_path))
  (setq elpy-modules (delq 'elpy-module-company elpy-modules)))

;(key-chord-define-global "el" 'elpy-shell-switch-to-shell)
;(key-chord-define-global "eb" 'elpy-shell-switch-to-buffer)
(elpy-enable)
;(pyvenv-activate (expand-file-name "/Users/phil/a50037/envs/a500try2/bin"))

(use-package yasnippet
  :ensure t
  :config
  (setq yas-triggers-in-field t)
  (setq yas-snippet-dirs
        '("~/repos/snippets"
          yas-installed-snippets-dir))
  (yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.
                                        ;http://orgmode.org/manual/Conflicts.html
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (add-hook 'org-mode-hook
            (lambda ()
              (setq-local yas/trigger-key [tab])
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

(use-package ripgrep
  :ensure t
  :config
  ;; Create shorter aliases
  (defalias 'rip 'ripgrep-regexp))



;;https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns))
    (setq exec-path-from-shell-variables (quote ("PATH" "MANPATH" "e340" "e340o" "e340n" "ecopy" "oecopy"
                                                 "or" "rm" "e340lib" "a500n" "a500d"
                                                 "e213" "e213s" "a405" "e582" "sphinxlib")))
    (exec-path-from-shell-initialize)))
  




