(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'latex-preview-pane-mode)
;; (setq TeX-PDF-mode t)

;; (setq TeX-view-program-selection
;;       '((output-dvi "DVI Viewer")
;;         (output-pdf "PDF Viewer")
;;         (output-html "HTML Viewer")))
;; ;; this example is good for OS X only
;; (setq TeX-view-program-list
;;       '(("DVI Viewer" "open %o")
;;         ("PDF Viewer" "open %o")
;;         ("HTML Viewer" "open %o")))

(provide 'auctex-settings)
