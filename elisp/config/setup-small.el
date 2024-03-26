;; (use-package quelpa
;;   :ensure t)

;; (if (require 'quelpa nil t)
;;     (quelpa '(quelpa :repo "quelpa/quelpa" :fetcher github) :upgrade t)
;;   (with-temp-buffer
;;     (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
;;     (eval-buffer)))

;(quelpa '(key-chord :fetcher wiki))
;(key-chord-mode 1)
;ey-chord-two-keys-delay 0.03)

(use-package markdown-mode
  :ensure t
)

(use-package filladapt
  :ensure t
  :config (setq-default filladapt-mode t))

;; (use-package rg
;;   (rg-enable-default-bindings)
;;   :ensure t)

(use-package dired-single
  :ensure t)

(use-package auto-complete
  :ensure t)

(use-package highlight-region
  :load-path "~/repos/dotfiles/elisp")

(use-package plocal
  :load-path "~/repos/dotfiles/elisp")

(use-package rst
  :load-path "~/repos/dotfiles/elisp")


(use-package visual-fill-column
  :ensure t
  :config
  ;;https://www.emacswiki.org/emacs/VisualLineMode
  (setq-default fill-column 100)
  (setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
  (add-hook 'minibuffer-setup-hook (lambda () (visual-line-mode -1)))
  (add-hook 'text-mode-hook 'turn-on-visual-line-mode)
  (add-hook 'text-mode-hook 'visual-fill-column-mode))

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

;; Configure Tempel
;; https://github.com/minad/corfu
;; https://github.com/minad/tempel
(use-package tempel
  :ensure t
  ;; Require trigger prefix before template name when completing.
  ;; :custom
  ;; (tempel-trigger-prefix "<")

  :bind (("M-+" . tempel-complete) ;; Alternative tempel-expand
         ("M-*" . tempel-insert))

  :init
  
  (defun tempel-setup-capf ()
    ;; Add the Tempel Capf to `completion-at-point-functions'.
    ;; `tempel-expand' only triggers on exact matches. Alternatively use
    ;; `tempel-complete' if you want to see all matches, but then you
    ;; should also configure `tempel-trigger-prefix', such that Tempel
    ;; does not trigger too often when you don't expect it. NOTE: We add
    ;; `tempel-expand' *before* the main programming mode Capf, such
    ;; that it will be tried first.
    (setq-local completion-at-point-functions
                (cons #'tempel-expand
                      completion-at-point-functions)))

  (add-hook 'prog-mode-hook 'tempel-setup-capf)
  (add-hook 'text-mode-hook 'tempel-setup-capf)

  ;; Optionally make the Tempel templates available to Abbrev,
  ;; either locally or globally. `expand-abbrev' is bound to C-x '.
 (add-hook 'prog-mode-hook #'tempel-abbrev-mode)
 (global-tempel-abbrev-mode)
)


;; Optional: Add tempel-collection.
;; The package is young and doesn't have comprehensive coverage.
;;(use-package tempel-collection)


(setq tempel-path "~/Dropbox/phil_files/emacs/snippets/*eld")

;; Optional: Use the Corfu completion UI


(use-package corfu
  :ensure t
  :init
  (global-corfu-mode))


;; (use-package yasnippet
;;   :ensure t
;;   :config
;;   (setq yas-triggers-in-field t)
;;   (setq yas-snippet-dirs
;;         '("~/Dropbox/phil_files/emacs/snippets"
;;           yas-installed-snippets-dir))
;;   (yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.
;;                                         ;http://orgmode.org/manual/Conflicts.html
;;   (yas-reload-all)
;;   (add-hook 'prog-mode-hook #'yas-minor-mode)
;;   (add-hook 'org-mode-hook
;;             (lambda ()
;;               (setq-local yas/trigger-key [tab])
;;               (define-key yas/keymap [tab] 'yas/next-field-or-maybe-expand))))

(use-package org-crypt
  :config
  (org-crypt-use-before-save-magic)
  ;; GPG key to use for encryption
  ;; Either the Key ID or set to nil to use symmetric encryption.
  (setq org-crypt-key nil))


(use-package auto-package-update
  :ensure t)

;; https://github.com/rranelli/auto-package-update.el
;; (auto-package-update-maybe)
;; (auto-package-update-now)


(use-package ripgrep
  :ensure t
  :config
  ;; Create shorter aliases
  (defalias 'rip 'ripgrep-regexp))



;;https://github.com/purcell/exec-path-from-shell
(use-package exec-path-from-shell
  :ensure t
  :config
  (setq exec-path-from-shell-variables (quote ("PATH" "MANPATH" "e340" "g340" "e340t1" "a340" "n340" "ecopy" "oecopy"
                                               "or" "rm" "e340lib" "a500n" "a500d" "a500r" "a448d" "a448r"
                                               "a405d" "a405r" "a405text"
                                               ))))


;; ;;https://github.com/purcell/exec-path-from-shell
;; (use-package exec-path-from-shell
;;   :ensure t
;;   :config
;;   (when (memq window-system '(mac ns))
;;     (setq exec-path-from-shell-variables (quote ("PATH" "MANPATH" "e340" "e340o" "e340n" "ecopy" "oecopy"
;;                                                  "or" "rm" "e340lib" "a500n" "a500d" "d340" "g340"
;;                                                  "e213" "e213s" "a405" "e582" "sphinxlib" "g211" "g340" "g211old")))))





