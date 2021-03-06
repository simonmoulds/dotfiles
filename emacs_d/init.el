;; init.el

;; path where settings files are kept

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/settings")

;; configure general settings
(require 'general-settings)
(require 'backup-settings)

;; ----------------------------------------------------------------------------
;; emacs 
;; ----------------------------------------------------------------------------

;; Math mode for LaTex
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

;; mouse scrolling
(mouse-wheel-mode t)

;; spellcheck in LaTeX mode
(add-hook `latex-mode-hook `flyspell-mode)
(add-hook `tex-mode-hook `flyspell-mode)
(add-hook `bibtex-mode-hook `flyspell-mode)

;; Show line-number and column-number in the mode line
(line-number-mode 1)
(column-number-mode 1)

;; highlight current line
;; (global-hl-line-mode 1)

;; ----------------------------------------------------------------------------
;; utilities
;; ----------------------------------------------------------------------------

;; auto-complete
(require 'auto-complete-settings)

;; ----------------------------------------------------------------------------
;; modes
;; ----------------------------------------------------------------------------

;; ido mode (iteratively do things)
(require 'ido)
(ido-mode t)

;; ;; fill column indicator mode
;; (require 'fill-column-indicator-settings)

;; python mode
(require 'python-settings)
(setq python-shell-interpreter-args "--simple-prompt --pprint")

;; ess mode
(require 'ess-settings)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/org/todo.org")))
 '(package-selected-packages
   (quote
    (latex-preview-pane pdf-tools virtualenvwrapper auctex volatile-highlights fill-column-indicator auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; mu4e
(require 'mu4e-settings)

;; map C-x C-b to ibuffer
(global-set-key "\C-x\C-b" 'ibuffer)

(when (fboundp 'winner-mode)
  (winner-mode 1))

;; org-mode
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; http://orgmode.org/manual/Fast-access-to-TODO-states.html#Fast-access-to-TODO-states
(setq org-todo-keywords
      '((sequence "TODO(t)" "|" "DONE(d)")))

(add-hook 'org-mode-hook '(lambda () (setq fill-column 80)))
(add-hook 'org-mode-hook 'turn-on-auto-fill)

;; AUCTeX
(require 'auctex-settings)
(put 'erase-buffer 'disabled nil)
