(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")

(setq user-mail-address "loukas.bass@gmx.com")

(require 'smtpmail)

; smtp
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

(setq mu4e-maildir (expand-file-name "~/.personal/Mail"))

(setq mu4e-drafts-folder "/loukas.bass/Drafts")
(setq mu4e-sent-folder "/loukas.bass/Sent")
(setq mu4e-trash-folder "/loukas.bass/Trash")

(setq mu4e-sent-messages-behavior 'sent)

(setq mu4e-attachment-dir "~/Downloads")

; get mail
(setq mu4e-get-mail-command "mbsync -a && pkill -RTMIN+2 i3blocks" ;; run i3blocks script, if u have one
      mu4e-html2text-command "w3m -T text/html"
      mu4e-update-interval 120
      mu4e-headers-auto-update t
      mu4e-compose-signature-auto-include nil)

(setq mu4e-maildir-shortcuts
      '( ("/Inbox" . ?i)
	 ("/loukas.bass/Inbox" . ?l)
         ("/loukas.bass/Sent" . ?s)
         ("/loukas.bass/Trash" . ?t)
         ("/loukas.bass/Drafts" . ?d)))

;; works better with mbsync (??)
(setq mu4e-change-filenames-when-moving t)

;; do not show all messages by default
(setq mu4e-headers-include-related nil)

;; show images
(setq mu4e-show-images t)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; alerts

(mu4e-alert-set-default-style 'libnotify)
(add-hook 'after-init-hook #'mu4e-alert-enable-notifications)
(add-hook 'after-init-hook #'mu4e-alert-enable-mode-line-display)

(setq mu4e-alert-interesting-mail-query
      (concat
       "flag:unread"
       " AND NOT flag:trashed"
       " AND NOT maildir:"
       "\"/Sent\""))
