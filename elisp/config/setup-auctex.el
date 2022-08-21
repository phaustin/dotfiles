;;http://cachestocaches.com/2015/8/getting-started-use-package/
(use-package tex
  :ensure auctex
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (add-hook 'LaTeX-mode-hook 'visual-line-mode)
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
  (setq reftex-plug-into-AUCTeX t)
  (setq TeX-view-program-selection
        '((output-pdf "PDF Viewer")))
  (setq TeX-view-program-list
        '(("PDF Viewer" "xpdf %o")))
  (setq TeX-PDF-mode t)
  (setq auto-mode-alist (cons '("\\.tex\\'" . latex-mode) auto-mode-alist))
  (setq reftex-insert-label-flags '("se" "sfte"))
                                        ;(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
  (setq reftex-enable-partial-scans t)
  (setq reftex-save-parse-info t)
  (setq reftex-use-multiple-selection-buffers t)
  (setq reftex-plug-into-AUCTeX t)
  (setq reftex-cite-format 'natbib)

  (add-hook 'LaTeX-mode-hook (lambda ()
                               (push
                                '("latexmk" "latexmk -gg -pdf %s" TeX-run-TeX nil t
                                  :help "Run latexmk on file")
                                TeX-command-list)))
  (add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

  ;; use Skim as default pdf viewer
  ;; Skim's displayline is used for forward search (from .tex to .pdf)
  ;; option -b highlights the current line; option -g opens Skim in the background  
  ;; (setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
  ;; (setq TeX-view-program-list
  ;;       '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))
  ;; )
  (setq TeX-view-program-list '(("Evince" "evince --page-index=%(outpage) %o")))
  (setq TeX-view-program-selection '((output-pdf "Evince"))))


;#
;# tex-buf bug
;# https://github.com/tom-tan/auctex-latexmk/pull/40/files
;# 
;; (use-package auctex-latexmk
;;   :ensure t
;;   :config
;;   (auctex-latexmk-setup)
;;   (setq auctex-latexmk-inherit-TeX-PDF-mode t)
;;   )

;https://www.reddit.com/r/emacs/comments/44yxsq/pdf_tools/
;; (use-package pdf-tools
;;     :ensure t
;;     :config
;;     (pdf-tools-install))
;;     ;; (setq TeX-view-program-selection '((output-pdf "pdf-tools")))
;;     ;; (setq TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view"))))


;; (defun th/pdf-view-revert-buffer-maybe (file)
;;   (let ((buf (find-buffer-visiting file)))
;;     (when buf 
;;   (with-current-buffer buf
;;     (when (derived-mode-p 'pdf-view-mode)
;;       (pdf-view-revert-buffer nil t))))))
;; (add-hook 'TeX-after-TeX-LaTeX-command-finished-hook
;;           #'th/pdf-view-revert-buffer-maybe)


;; ;; ;http://mbork.pl/2016-06-13_Displaying_pdfs_on_the_right

;; (defvar pdf-minimal-width 72
;;   "Minimal width of a window displaying a pdf.
;; If an integer, number of columns.  If a float, fraction of the
;; original window.")

;; (defvar pdf-split-width-threshold 120
;;   "Minimum width a window should have to split it horizontally
;; for displaying a pdf in the right.")

;; (defun pdf-split-window-sensibly (&optional window)
;;   "A version of `split-window-sensibly' for pdfs.
;; It prefers splitting horizontally, and takes `pdf-minimal-width'
;; into account."
;;   (let ((window (or window (selected-window)))
;;         (width (- (if (integerp pdf-minimal-width)
;;                       pdf-minimal-width
;;                     (round (* pdf-minimal-width (window-width window)))))))
;;     (or (and (window-splittable-p window t)
;;              ;; Split window horizontally.
;;              (with-selected-window window
;;                (split-window-right width)))
;;         (and (window-splittable-p window)
;;              ;; Split window vertically.
;;              (with-selected-window window
;;                (split-window-below)))
;;         (and (eq window (frame-root-window (window-frame window)))
;;              (not (window-minibuffer-p window))
;;              ;; If WINDOW is the only window on its frame and is not the
;;              ;; minibuffer window, try to split it vertically disregarding
;;              ;; the value of `split-height-threshold'.
;;              (let ((split-height-threshold 0))
;;                (when (window-splittable-p window)
;;                  (with-selected-window window
;;                    (split-window-below))))))))

;; (defun display-buffer-pop-up-window-pdf-split-horizontally (buffer alist)
;;   "Call `display-buffer-pop-up-window', using `pdf-split-window-sensibly'
;; when needed."
;;   (let ((split-height-threshold nil)
;;         (split-width-threshold pdf-split-width-threshold)
;;         (split-window-preferred-function #'pdf-split-window-sensibly))
;;     (display-buffer-pop-up-window buffer alist)))

;; (add-to-list 'display-buffer-alist '("\\.pdf\\(<[^>]+>\\)?$" . (display-buffer-pop-up-window-pdf-split-horizontally)))

;https://github.com/politza/pdf-tools/issues/25

;; (setq auto-revert-interval 0.5)
;; (auto-revert-set-timer)
