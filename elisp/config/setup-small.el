
(use-package filladapt
  :load-path "~/repos/dotfiles/elisp"
  :config (setq-default filladapt-mode t))

(use-package highlight-region
  :load-path "~/repos/dotfiles/elisp")

(use-package plocal
  :load-path "~/repos/dotfiles/elisp")

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
