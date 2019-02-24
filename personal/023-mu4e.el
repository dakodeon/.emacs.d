(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")

(require 'smtpmail)

; smtp defaults
(setq message-send-mail-function 'smtpmail-send-it
      ;; smtpmail-starttls-credentials
      ;; '(("mail.gmx.com" 587 nil nil))
      smtpmail-default-smtp-server "mail.gmx.com"
      smtpmail-smtp-server "mail.gmx.com"
      smtpmail-smtp-user "loukas.bass@gmx.com"
      smtpmail-stream-type 'starttls
      smtpmail-smtp-service 587
      smtpmail-debug-info t)

(require 'mu4e)
(require 'org-mu4e)

(setq mu4e-maildir (expand-file-name "~/.personal/Mail"))

(setq mu4e-drafts-folder "/loukas.bass/Drafts")
(setq mu4e-sent-folder "/loukas.bass/Sent")
(setq mu4e-trash-folder "/loukas.bass/Trash")

(setq mu4e-sent-messages-behavior 'sent)

(setq mu4e-attachment-dir "~/Downloads")

; get mail
(setq mu4e-get-mail-command "mbsync -a"
      mu4e-html2text-command "w3m -T text/html"
      mu4e-update-interval 60
      mu4e-headers-auto-update t
      mu4e-compose-signature-auto-include nil)

;; maildirs shortcuts
(setq mu4e-maildir-shortcuts
      '( ("/Inbox" . ?i)
	 ("/loukas.bass/Inbox" . ?l)
         ("/loukas.bass/Sent" . ?s)
         ("/loukas.bass/Trash" . ?t)
         ("/loukas.bass/Drafts" . ?D)
	 ("/gmail/Inbox" . ?g)
	 ("/dakodeon/Inbox" . ?d)))

;; contexts
(setq mu4e-contexts
      `( ,(make-mu4e-context
	   :name "loukas.bass"
	   :match-func (lambda (msg)
			 (when msg
			   (mu4e-message-contact-field-matches msg
							       :to "loukas.bass@gmx.com")))
	   :vars '((smtpmail-smtp-user . "loukas.bass@gmx.com")
		   (smtpmail-default-smtp-server . "mail.gmx.com")
		   (smtpmail-smtp-server . "mail.gmx.com")
		   (user-mail-address . "loukas.bass@gmx.com")
		   (user-full-name . "loukas bass")
		   (mu4e-sent-folder . "/loukas.bass/Sent")
		   (mu4e-drafts-folder . "/loukas.bass/Drafts")
		   (mu4e-trash-folder . "/loukas.bass/Trash")))
	 ,(make-mu4e-context
	   :name "gmail"
	   :match-func (lambda (msg)
			 (when msg
			   (mu4e-message-contact-field-matches msg
							       :to "freehuggs701@gmail.com")))
	   :vars '((smtpmail-smtp-user . "freehuggs701@gmail.com")
		   (smtpmail-default-smtp-server . "smtp.gmail.com")
		   (smtpmail-smtp-server . "smtp.gmail.com")
		   (user-mail-address . "freehuggs701@gmail.com")
		   (user-full-name . "freexon")
		   (mu4e-sent-folder . "/gmail/[Gmail]/Sent Mail")
		   (mu4e-drafts-folder . "/gmail/Drafts")
		   (mu4e-trash-folder . "/gmail/Trash")))
	 ,(make-mu4e-context
	   :name "dakodeon"
	   :match-func (lambda (msg)
			 (when msg
			   (mu4e-message-contact-field-matches msg
							       :to "dakodeon@hotmail.com.com")))
	   :vars '((smtpmail-smtp-user . "dakodeon@hotmail.com")
		   (smtpmail-default-smtp-server . "smtp.office365.com")
		   (smtpmail-smtp-server . "smtp.office365.com")
		   (user-mail-address . "dakodeon@hotmail.com")
		   (user-full-name . "loukas b")
		   (mu4e-sent-folder . "/dakodeon/Sent")
		   (mu4e-drafts-folder . "/dakodeon/Drafts")
		   (mu4e-trash-folder . "/dakodeon/Trash")))))

(setq mu4e-context-policy 'pick-first)

;; update in background
(setq mu4e-index-update-in-background t)
(setq mu4e-hide-index-messages t)

;; works better with mbsync (??)
(setq mu4e-change-filenames-when-moving t)

;; do not show all messages by default
(setq mu4e-headers-include-related nil)

;; show images
(setq mu4e-show-images t)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; kill message buffers after editing
(setq message-kill-buffer-on-exit t)

;; compose with orgmode
(add-hook 'mu4e-compose-mode-hook
  (lambda()
    (local-set-key (kbd "C") 'org-mu4e-compose-org-mode)
    ))

(setq org-mu4e-convert-to-html t)

;; each time the index is updated, or an email is being viewed, run i3blocks script
(add-hook 'mu4e-index-updated-hook
	  (defun mu4e-signal-i3blocks ()
	    (shell-command "pkill -RTMIN+2 i3blocks")))

(add-hook 'mu4e-view-mode-hook 'mu4e-signal-i3blocks)

;; alerts
(mu4e-alert-set-default-style 'libnotify)
(add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)

(setq mu4e-alert-interesting-mail-query
      (concat
       "flag:unread"
       " AND maildir:/loukas.bass/Inbox"))

;; open mu4e in headers-view of account
(defun mu4e-open-in-headers (account)
  "Open mu4e in account's Inbox"
  (interactive)
  (mu4e~start)
  (if (get-buffer "*mu4e-headers*" )
      (switch-to-buffer "*mu4e-headers*"))
  (mu4e-headers-search (concat "maildir:/" account "/Inbox")))

;; start mu4e
(global-set-key (kbd "C-x m") 'mu4e)

;; AUTOSTART MU4E
(mu4e~start)
