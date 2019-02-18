;; org mode

(setq org-directory "~/.personal")
(setq org-default-notes-file (concat org-directory "/organizer.org"))
(setq org-hide-leading-stars t)
(setq org-log-done 'time)

;; only for email -- maybe later make this local?
(setq org-export-with-toc nil)
(setq org-export-with-section-numbers nil)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "" "Tasks")
         "* TODO %?\n  %i\n  %a")
	
        ("j" "Journal" entry (file+datetree "journal.org")
         "* %^{entry title}\n%U\n  %?\n  %a")

	("b" "Web purchase" entry (file+headline "web-stuff.org" "Purchases")
	 "* ORDERED %^{item desc.}\n\n%x\n\nEst. delivery: %?\n\nOrder placed on: %U")

	("l" "Link" entry (file+headline "web-stuff.org" "Links")
	 "* %x %^g\n %?\n%U")

	("c" "Contact" entry (file "contacts.org")
	 "* %^{nickname}\n:PROPERTIES:\n:NAME: %^{name}\n:EMAIL: [[%^{email}]]\n:END:")
	))

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
