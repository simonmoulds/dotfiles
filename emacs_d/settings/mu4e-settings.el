(add-to-list 'load-path "/usr/share/local/emacs/site-lisp/mu4e")
(require 'smtpmail)

;; smtp
(setq message-send-mail-function 'smtpmail-send-it)

;; default settings
(setq smtpmail-default-smtp-server "smtp.office365.com"
      smtpmail-smtp-server "smtp.office365.com"
      smtpmail-stream-type 'starttls
      smtpmail-smtp-service 587)
      ;; smtpmail-debug-info t)

(require 'mu4e)

;; contexts
(setq mu4e-compose-context-policy 'ask-if-none
      mu4e-context-policy 'pick-first
      mu4e-contexts
      `( ,(make-mu4e-context
	   :name "ic"
	   :enter-func (lambda () (mu4e-message "Entering ic context"))
	   :leave-func (lambda () (mu4e-message "Leaving ic context"))
	   :match-func (lambda (msg)
			 (when msg
			   (string-match-p "^/ic" (mu4e-message-field msg :maildir))))
	   :vars '((smtpmail-smtp-user           . "sm510@ic.ac.uk")
		   (smtpmail-default-smtp-server . "smtp.office365.com")
		   (smtpmail-smtp-server         . "smtp.office365.com")
		   (smtpmail-smtp-service        . 587)
		   (mail-reply-to                . "simon.moulds@imperial.ac.uk")
		   (user-mail-address            . "simon.moulds@imperial.ac.uk")
		   (user-full-name               . "Simon Moulds")
		   (mu4e-compose-signature       . t)))
	 ,(make-mu4e-context
	   :name "gmail"
	   :enter-func (lambda () (mu4e-message "Switch to Gmail"))
	   :match-func (lambda (msg)
			 (when msg
			   (string-match-p "^/gmail" (mu4e-message-field msg :maildir))))
	   :vars '((smtpmail-smtp-user           . "sim.moulds@gmail.com")
		   (smtpmail-default-smtp-server . "smtp.gmail.com")
		   (smtpmail-smtp-server         . "smtp.gmail.com")
		   (smtpmail-smtp-service        . 587)
		   (mail-reply-to                . "sim.moulds@gmail.com")
		   (user-mail-address            . "sim.moulds@gmail.com")
		   (user-full-name               . "Simon Moulds")
		   (mu4e-compose-signature       . t)))))

(setq mu4e-maildir (expand-file-name "~/mail"))

(defun my-mu4e-sent-folder-function (msg)
  "Set the sent folder for the current message."
  (let ((from-address (message-field-value "From"))
	(to-address (message-field-value "To")))
    (cond
     ((string-match "simon.moulds@imperial.ac.uk" from-address)
	"/ic/Sent Items")
     ((string-match "sim.moulds@gmail.com" from-address)
      "/Gmail/[Gmail].Sent Mail")
     (t (mu4e-ask-maildir-check-exists "Save message to maildir: ")))))

(setq mu4e-sent-folder 'my-mu4e-sent-folder-function)
;; (setq mu4e-sent-folder   "/sent")
(setq mu4e-drafts-folder "/drafts")
(setq mu4e-trash-folder  "/trash")
(setq message-signature-file "~/.emacs.d/.signature") ; put your signature in this file

; get mail
(setq mu4e-get-mail-command "mbsync -ca ~/.emacs.d/.mbsyncrc"
      ;; mu4e-html2text-command "w3m -T text/html"
      mu4e-update-interval 120
      mu4e-headers-auto-update t
      mu4e-compose-signature-auto-include nil)


(setq mu4e-maildir-shortcuts
      '( ("/ic/INBOX"     . ?i)
         ;; ("/work/INBOX"   . ?j)         
         ("/gmail/INBOX"  . ?j)))
	 ;; ("/sent"         . ?s)
	 ;; ("/trash"        . ?t)
	 ;; ("/drafts"       . ?d)))

;; show images
(setq mu4e-show-images t)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; general emacs mail settings; used when composing e-mail
;; the non-mu4e-* stuff is inherited from emacs/message-mode
(setq mu4e-reply-to-address "sim.moulds@gmail.com"
      user-mail-address "sim.moulds@gmail.com"
      user-full-name  "Simon Moulds")

;; ;; don't save message to Sent Messages, IMAP takes care of this
;; (setq mu4e-sent-messages-behavior 'delete)

;; spell check
(add-hook 'mu4e-compose-mode-hook
	  (defun my-do-compose-stuff ()
	    "My settings for message composition."
	    (set-fill-column 72)
	    (flyspell-mode)))

(add-to-list 'mu4e-view-actions
	     '("ViewInBrowser" . mu4e-action-view-in-browser) t)

(defun no-auto-fill ()
  "Turn off auto-fill-mode."
  (auto-fill-mode -1))

(add-hook 'mu4e-compose-mode-hook #'no-auto-fill)

(provide 'mu4e-settings)

;; old:

;; (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
;; (require 'smtpmail)

;; ;; smtp
;; (setq message-send-mail-function 'smtpmail-send-it
;;       ;; smtpmail-starttls-credentials
;;       ;; '(("smtp.office365.com" 587 nil nil))
;;       ;; smtpmail-default-smtp-server "smtp.office365.com"
;;       smtpmail-smtp-server "smtp.office365.com"
;;       smtpmail-stream-type 'starttls
;;       smtpmail-smtp-service 587)
;;       ;; smtpmail-debug-info t)

;; (require 'mu4e)

;; (setq mu4e-maildir (expand-file-name "~/mail/work"))

;; (setq mu4e-drafts-folder "/Drafts")
;; (setq mu4e-sent-folder   "/Sent Items")
;; (setq mu4e-trash-folder  "/Trash")
;; (setq message-signature-file "~/.emacs.d/.signature") ; put your signature in this file

;; ; get mail
;; (setq mu4e-get-mail-command "mbsync -c ~/.emacs.d/.mbsyncrc work"
;;       mu4e-html2text-command "w3m -T text/html"
;;       mu4e-update-interval 120
;;       mu4e-headers-auto-update t
;;       mu4e-compose-signature-auto-include nil)

;; (setq mu4e-maildir-shortcuts
;;       '( ("/INBOX"        . ?i)
;; 	 ("/Sent Items"   . ?s)
;; 	 ("/Trash"        . ?t)
;; 	 ("/Drafts"       . ?d)))

;; ;; show images
;; (setq mu4e-show-images t)

;; ;; use imagemagick, if available
;; (when (fboundp 'imagemagick-register-types)
;;   (imagemagick-register-types))

;; ;; general emacs mail settings; used when composing e-mail
;; ;; the non-mu4e-* stuff is inherited from emacs/message-mode
;; (setq mu4e-reply-to-address "s.moulds@exeter.ac.uk"
;;       user-mail-address "s.moulds@exeter.ac.uk"
;;       user-full-name  "Simon Moulds")

;; ;; don't save message to Sent Messages, IMAP takes care of this
;; (setq mu4e-sent-messages-behavior 'delete)

;; ;; spell check
;; (add-hook 'mu4e-compose-mode-hook
;; 	  (defun my-do-compose-stuff ()
;; 	    "My settings for message composition."
;; 	    (set-fill-column 72)
;; 	    (flyspell-mode)))

;; (provide 'mu4e-settings)
