;; uncomment this line to disable loading of "default.el" at startup
(setq inhibit-default-init t)

;; enable MELPA library
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/"))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    ein
    elpy
    flycheck
    material-theme
    py-autopep8))

(mapc #'(lambda (package)
	  (unless (package-installed-p package)
	    (package-install package)))
      myPackages)

;; (setq frame-title-format
;;       (concat  "%b - emacs@" (system-name)))

;; ;; default to unified diffs
;; (setq diff-switches "-u")

;; ;; always end a file with a newline
;; (setq require-final-newline 'query)

;; ;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)

;; ;; sensible word wrapping
;; (setq-default word-wrap t)
;; (global-visual-line-mode t)

;; BASIC CUSTOMIZATION
;; -------------------

(setq column-number-mode t)
(setq inhibit-startup-message t) ;; hide the startup message
;; (load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally

(provide 'general-settings)
