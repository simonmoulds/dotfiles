;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Simon Moulds"
      user-mail-address "sim.moulds@gmail.com")

;; ;; Font settings
;; (setq doom-font (font-spec :family "RobotoMono Nerd Font"  :size 18)
;;       doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font Mono" :size 15))

;; Theme
(setq doom-theme 'doom-one)
(setq doom-one-brighter-comments t
      doom-one-comment-bg nil)

;; Set line-number style
(setq display-line-numbers-type 'relative)

;; Mac
(setq mac-control-modifier 'control)
(setq mac-command-modifier 'meta)
(setq mac-right-option-modifier 'control)

;; Path addtion
(cond (IS-MAC (setenv "PATH" (concat (getenv "PATH") ":/Library/TeX/texbin"))
              (setq exec-path (append exec-path '("/Library/TeX/texbin")))
              )
      )

;; Start in fullscreen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Make Y yank the whole line
(evil-put-command-property 'evil-yank-line :motion 'evil-line)

(global-visual-line-mode t)

;; Exit insert mode by pressing j twice quickly
(setq key-chord-two-keys-delay 0.1)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)
(setq evil-escape-key-sequence nil)

;; doom-mode-line stuff
(setq doom-modeline-enable-word-count t)

(setq undo-limit 80000000
      evil-want-fine-undo t
      auto-save-default t)

(display-time-mode 1)

;; ;; mu4e setup
;; (after! mu4e
;;   (setq mu4e-root-maildir (expand-file-name "~/.local/share/mail/essb")
;;         mu4e-get-mail-command "mbsync -a -c \"$XDG_CONFIG_HOME/isync/mbsyncrc\""
;;         mu4e-index-update-in-background t
;;         mu4e-use-fancy-chars t
;;         mu4e-view-show-addresses t
;;         mu4e-view-show-images t
;;         mu4e-compose-format-flowed t
;;         mu4e-compose-signature-auto-include nil
;;         mu4e-view-use-gnus t
;;         mu4e-change-filenames-when-moving t
;;         message-send-mail-function 'smtpmail-send-it
;;         message-citation-line-format "On %a %d %b %Y at %R, %f wrote:\n"
;;         message-citation-line-function 'message-insert-formatted-citation-line
;;         message-kill-buffer-on-exit t
;;         org-mu4e-convert-to-html t)
;;   (add-hook 'mu4e-compose-mode-hook 'turn-off-auto-fill)
;;   (add-hook 'mu4e-compose-mode-hook (lambda() (use-hard-newlines -1))))

;; ;; Email alert
;; (add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)

;; ;; Setup email account
;; (set-email-account! "essb"
;;                     '((mu4e-sent-folder                 .       "/essb/Sent")
;;                       (mu4e-drafts-folder               .       "/essb/Drafts")
;;                       (mu4e-trash-folder                .       "/essb/Trash")
;;                       (mu4e-refile-folder               .       "/essb/INBOX")
;;                       (message-send-mail-function       .       smtpmail-send-it)
;;                       (smtpmail-smtp-user               .       "45995wsp@eur.nl")
;;                       (smtpmail-smtp-server             .       "localhost")
;;                       (smtpmail-smtp-service            .       1025)
;;                       (smtpmail-stream-type             .       nil)
;;                       (user-mail-address                .       "spekkink@essb.eur.nl")
;;                       (mu4e-update-interval             .       300))
;;                     t)


;; org-mode related stuff
(after! org

  ;; Set org directories
  (setq org-directory "~/org/")
  (setq org-default-notes-file "~/org/refile.org")
  (setq org-agenda-files (quote("~/org/"
                                ;; "~/org/synced/"
                                "~/org/notes/"
                                "~/org/notes/daily/"
                                "~/org/notes/literature/"
                                "~/org/notes/references/"
                                )))

  (setq org-refile-targets '(("~/org/agenda.org" :maxlevel . 3)
                             ("~/org/someday.org" :maxlevel . 1)
                             ("~/org/tickler.org" :maxlevel . 2)))

  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq org-ellipsis " ▼ ")
  (setq org-hide-emphasis-markers t)
  (setq org-log-done 'time)

  ;; (add-to-list 'org-latex-classes
  ;;              '("report"
  ;;                "\\documentclass{report}"
  ;;                ("\\chapter{%s}" . "\\chapter*{%s}")
  ;;                ("\\section{%s}" . "\\section*{%s}")
  ;;                ("\\subsection{%s}" . "\\subsection*{%s}")
  ;;                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

  ;; (add-to-list 'org-latex-classes
  ;;              '("paper"
  ;;                "\\documentclass{article}"
  ;;                ("\\section{%s}" . "\\section*{%s}")
  ;;                ("\\subsection{%s}" . "\\subsection*{%s}")
  ;;                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
  ;;                ("\\paragraph{%s}" . "\\paragraph*{%s}")
  ;;                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  (defun org-export-latex-no-toc (depth)
    (when depth
      (format "%% Org-mode is exporting headings to %s levels.\n"
              depth)))

  (after! org-capture
    (setq org-capture-templates '(
            ;; ("t" "task (agenda.org)" entry (file+headline "agenda.org" "Single Tasks")
            ;;  "* TODO %?")
            ;; ("s" "scheduled task (agenda.org)" entry (file+headline "agenda.org" "Single Tasks")
            ;;  "* TODO %?\nSCHEDULED: %^t\n")
            ;; ;; ("b" "buy (add to shopping list in todo.org)" entry (file+headline "todo.org" "Shopping list")
            ;; ;;  "* TODO buy %?")
            ;; ("a" "appointment (schedule.org)" entry (file+headline "schedule.org" "Calendar")
            ;;  "* %?\n%^t")
            ("i" "inbox entry" entry (file "inbox.org")
             "* %?\n")
            ("j" "journal/logbook entry (logbook.org)" entry (file+datetree "logbook.org")
              "* %<%H:%M>\n%?\n" :tree-type week)
            ;; '("j" "Journal entry" entry (function org-journal-find-location)
            ;;   "* %(format-time-string org-journal-time-format)%\n%i%?")
            ; from browser:
            ("l" "link (from browser)" entry (file "inbox.org")
             ;; "* %a\n %?\n %i" :immediate-finish t))
             "* %a\n %?\n %i\n")
            )
    )
    (setq org-protocol-default-template-key "l")
    )

  (setq +zen-text-scale 0.9
        writeroom-extra-line-spacing 0.3
        doom-variable-pitch-font (font-spec :family "Fira Sans" :size 18)
        writeroom-fullscreen-effect t)

  ;; ;; org-noter stuff
  ;; (after! org-noter
  ;;   (setq
  ;;    org-noter-notes-search-path "~/org/org-roam/references/"
  ;;    org-noter-hide-other nil
  ;;    org-noter-separate-notes-from-heading t
  ;;    org-noter-always-create-frame nil)
  ;;   (map!
  ;;    :map org-noter-doc-mode-map
  ;;    :leader
  ;;    :desc "Insert note"
  ;;    "m i" #'org-noter-insert-note
  ;;    :desc "Insert precise note"
  ;;    "m p" #'org-noter-insert-precise-note
  ;;    :desc "Go to previous note"
  ;;    "m k" #'org-noter-sync-prev-note
  ;;    :desc "Go to next note"
  ;;    "m j" #'org-noter-sync-next-note
  ;;    :desc "Create skeleton"
  ;;    "m s" #'org-noter-create-skeleton
  ;;    :desc "Kill session"
  ;;    "m q" #'org-noter-kill-session
  ;;    )
  ;;   )

  )

;; File templates and stuff
(set-file-template! "/paper\\.org$" :trigger "__paper.org" :mode 'org-mode)

;; (after! hl-todo
;;   (global-hl-todo-mode t))
(global-hl-todo-mode t)


;; ;; This is to use pdf-tools instead of doc-viewer
;; (use-package! pdf-tools
;;   :config
;;   (pdf-tools-install)
;;   (setq-default pdf-view-display-size 'fit-width)
;;   :custom
;;   (pdf-annot-activate-created-annotations t "automatically annotate highlights"))
(setq org-roam-v2-ack t)

;; org-roam related things
(after! org-roam

  (map! :leader
        :prefix "n"
        :desc "org-roam" "l" #'org-roam-buffer-toggle
        :desc "org-roam-node-insert" "i" #'org-roam-node-insert
        :desc "org-roam-node-find" "f" #'org-roam-node-find
        :desc "org-roam-ref-find" "r" #'org-roam-ref-find
        :desc "org-roam-show-graph" "g" #'org-roam-show-graph
        ;; :desc "jethro/org-capture-slipbox" "<tab>" #'jethro/org-capture-slipbox)
        :desc "org-roam-capture" "c" #'org-roam-capture
        ;; :desc "org-roam-dailies-capture-today" "t" #'org-roam-dailies-capture-today
        )

  (map! :leader
        :prefix "n"
        (:prefix-map ("d" . "dailies")
         :desc "org-roam-dailies-capture-today" "t" #'org-roam-dailies-capture-today
         :desc "org-roam-dailies-capture-yesterday" "y" #'org-roam-dailies-capture-yesterday
         :desc "org-roam-dailies-capture-tomorrow" "T" #'org-roam-dailies-capture-tomorrow)
        ;; Remap deft, which was previously bound to n d
        :desc "Open deft" "D" #'deft)

  (setq org-roam-directory "~/org/notes/")

  (add-hook 'after-init-hook 'org-roam-mode)

  ;; Configure citar
  (setq citar-bibliography '("~/Dropbox/Documents/Zotero_library.bib")
        org-cite-global-bibliography '("~/Dropbox/Documents/Zotero_library.bib")
        citar-notes-paths '("~/org/notes/literature")
        citar-file-open-prompt t
        org-cite-insert-processor 'citar
        org-cite-follow-processor 'citar
        org-cite-activate-processor 'citar
        org-support-shift-select t
        ;; include property drawer metadata for 'org-roam' v2 in literature notes:
        ;; (when (featurep! :land org +roam2)
        ;;   ;; Include property drawer metadata for 'org-roam' v2.
        ;;   (citar-file-note-org-include '(org-id org-roam-ref)))
        )


  ;; (after! citar
  ;;   (add-to-list 'citar-templates '(note . "#+title: ${author editor} ${date year issued:4} ${title}")))

  (setq org-id-method 'ts)
  (setq org-id-ts-format "%Y%m%dT%H%M%S")
  (setq org-roam-capture-templates
        (list
         '("n" "default note" plain "%?"
           :if-new (file+head "%<%Y%m%d>-${slug}.org"
                    "#+TITLE: ${title}\n\n")
           :unnarrowed t)
         ;; '("b" "blog post" plain "%?"
         ;;   :if-new (file+head "blog/%<%Y%m%d>-${slug}.org"
         ;;            "#+TITLE: ${title}\n\n")
         ;;   :unnarrowed t)
         ;; '("p" "new paper" plain "%?"
         ;;   :if-new (file+head "papers/%<%Y>-${slug}.org"
         ;;            "#+TITLE: ${title}\n\n")
         ;;   :unnarrowed t)
         ;; '("l" "literature note" plain "%?"
         ;;  :if-new (file+head "literature/${citekey}.org"
         ;;                     "#+TITLE: ${author-or-editor} ${year} ${title}\n")
         ;;  ))
        ))

  ;; And now we set necessary variables for org-roam-dailies
  (setq org-roam-dailies-directory "daily/")
  (setq org-roam-dailies-capture-templates
        '(("d" "default" entry
           "* %?"
           :if-new (file+head "%<%Y-%m-%d>.org"
           "#+title: %<%Y-%m-%d>\n"))))

  (use-package! websocket
    :after org-roam)

  (use-package! org-roam-ui
    :after org-roam
    :commands org-roam-ui-open
    :hook (org-roam . org-roam-ui-mode)
    :config
    (require 'org-roam) ; in case autoloaded
    (defun org-roam-ui-open ()
      "Ensure the server is active, then open the roam graph."
      (interactive)
      (unless org-roam-ui-mode (org-roam-ui-mode 1))
      (browse-url-xdg-open (format "http://localhost:%d" org-roam-ui-port))))

  ;; ;; org-roam-bibtex stuff
  ;; (use-package! org-roam-bibtex)
  ;; (org-roam-bibtex-mode)

  ;; (setq orb-preformat-keywords
  ;;       '("citekey" "title" "url" "author-or-editor" "keywords" "file")
  ;;       orb-process-file-keyword t
  ;;       orb-file-field-extensions '("pdf"))

  ;; ;; Let's set up some org-roam capture templates
  ;; (setq org-roam-capture-templates
  ;;       (quote (("d" "default" plain
  ;;                "%?"
  ;;                :if-new (file+head "%<%Y-%m-%d-%H%M%S>-${slug}.org"
  ;;                "#+title: ${title}\n")
  ;;                :unnarrowed t)
  ;;               ("r" "bibliography reference" plain
  ;;                (file "~/org/org-roam/templates/orb-capture")
  ;;                :if-new
  ;;                (file+head "references/${citekey}.org" "#+title: ${title}\n")))))

  ;; ;; Function to capture quotes from pdf
  ;; (defun org-roam-capture-pdf-active-region ()
  ;;   (let* ((pdf-buf-name (plist-get org-capture-plist :original-buffer))
  ;;          (pdf-buf (get-buffer pdf-buf-name)))
  ;;     (if (buffer-live-p pdf-buf)
  ;;         (with-current-buffer pdf-buf
  ;;           (car (pdf-view-active-region-text)))
  ;;       (user-error "Buffer %S not alive." pdf-buf-name)))

  )

;; (cl-defmethod org-roam-node-directories ((node org-roam-node))
;;   (if-let ((dirs (file-name-directory (file-relative-name (org-roam-node-file node) org-roam-directory))))
;;       (format "(%s)" (string-join (f-split dirs) "/"))
;;     ""))

(setq org-roam-node-display-template "${directories:10} ${title:*} ${tags:10}")

;; For deft
(after! deft
  (setq deft-extensions '("org")
        deft-directory org-roam-directory
        deft-recursive t
        deft-strip-summary-regexp ":PROPERTIES:\n\\(.+\n\\)+:END:\n")

  (setq deft-strip-summary-regexp ":PROPERTIES:\n\\(.+\n\\)+:END:\n")

  (setq deft-use-filename-as-title 't)

  (map! :map deft-mode-map
        :n "gr"  #'deft-refresh
        :n "r"   #'deft-rename-file
        :n "a"   #'deft-new-file
        :n "A"   #'deft-new-file-named
        :n "d"   #'deft-delete-file
        :n "D"   #'deft-archive-file
        :n "q"   #'kill-current-buffer)
  )

;; Call org-capture (e.g. to enter todo items or update log book)
(map!
 :leader
 :desc "org-capture" "x" #'org-capture
 )

;; ;; General org-roam functions
;; (after! org-roam
;;   (map! :leader
;;         :prefix "n"
;;         :desc "org-roam-buffer-toggle" "r" #'org-roam-buffer-toggle
;;         :desc "org-roam-node-insert" "i" #'org-roam-node-insert
;;         :desc "org-roam-node-find" "f" #'org-roam-node-find
;;         :desc "org-roam-show-graph" "g" #'org-roam-show-graph
;;         :desc "org-roam-capture" "c" #'org-roam-capture
;;         )
;;   )

;; Open/create org-roam literature note
(map!
 :leader
 :desc "open org note for literature item" "n p" #'citar-open-notes
 )

;; Add and remove org-roam tabs
(map!
 :leader
 :prefix "n"
 :desc "add org-roam tag" "t" #'org-roam-tag-add
 :desc "remove org-roam tag" "T" #'org-roam-tag-remove
)

;; Insert yas snippet in edit mode
(map! :desc "insert snippet" "C-s" #'yas-insert-snippet)

(map!
 :desc "insert citation" "C-c c" #'citar-insert-citation
 )

;; ;; Insert link to another org-roam note in edit mode
;; (defun my-insert-link-to-note ()
;;   "insert link to org node and prompt for link text"
;;   (interactive)
;;   (org-roam-node-insert)
;;   (call-interactively #'org-insert-link)
;;   )

(after! org-roam
  (map!
   :desc "insert link to node" "C-c i" #'my-insert-link-to-note
   )
  )

;; Insert link to heading in edit mode
(map!
 :desc "link to heading" "C-c l" #'my-insert-custom-id-link
 )

;; ;; Insert footnote in edit mode
;; (map!
;;  :desc "footnote action" "C-c f" #'org-footnote-action
;;  )

;; ;; Delete footnote
;; (defun my-access-footnote-menu ()
;;   (interactive)
;;   (org-footnote-action t)
;;   )

;; ESS-related customization
(after! ess
  ;; https://github.com/hlissner/doom-emacs/issues/2327#issuecomment-684672111
  (map!
   (:map ess-roxy-mode-map
    :i     "RET" #'ess-indent-new-comment-line
    ))

  (use-package! poly-R
    :config
    (map! (:localleader
           :map polymode-mode-map
           :desc "Export"   "e" 'polymode-export
           :desc "Errors" "$" 'polymode-show-process-buffer
           :desc "Weave" "w" 'polymode-weave
           ;; (:prefix ("n" . "Navigation")
           ;;  :desc "Next" "n" . 'polymode-next-chunk
           ;;  :desc "Previous" "N" . 'polymode-previous-chunk)
           ;; (:prefix ("c" . "Chunks")
           ;;  :desc "Narrow" "n" . 'polymode-toggle-chunk-narrowing
           ;;  :desc "Kill" "k" . 'polymode-kill-chunk
           ;;  :desc "Mark-Extend" "m" . 'polymode-mark-or-extend-chunk)
           ))
    )
  )


;; ;; openwith customization
;; (use-package! openwith
;;   ;; :after-call pre-command-hook
;;   :config
;;   (openwith-mode t)
;;   (add-to-list 'openwith-associations '("\\.pdf\\'" "open" (file))))
