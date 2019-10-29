;; org mode

(require 'org-tempo)

(setq org-hide-leading-stars t)

(setq org-directory "~/.personal")
(setq org-default-notes-file (concat org-directory "/organizer.org"))
(setq org-log-done 'time)

;; code blocks options
(setq org-src-fontify-natively t
    org-src-tab-acts-natively t
    org-confirm-babel-evaluate nil
    org-edit-src-content-indentation 0)

;; only for email -- maybe later make this local?
(setq org-export-with-toc nil)
(setq org-export-with-section-numbers nil)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "" "Tasks")
         "* TODO %?\n  %i\n  %a")
	
        ("j" "Journal" entry (file+datetree "journal.org")
         "* %^{entry title}\n%U\n  %?\n  %a")

	("B" "Web purchase" entry (file+headline "web-stuff.org" "Purchases")
	 "* ORDERED %^{item desc.}\n\n%x\n\nEst. delivery: %?\n\nOrder placed on: %U")
	
	("l" "Link" entry (file+headline "web-stuff.org" "Links")
	 "* %x %^g\n %?\n%U")

	("b" "Bibliography reference" entry (file "bib-references.org")
	 "* @%^{.bib entry}: %^{description} %^g\n %^{page(s)} %?\n%U")
	
	("c" "Contact" entry (file "contacts.org")
	 "* %^{nickname}\n:PROPERTIES:\n:NAME: %^{name}\n:EMAIL: [[%^{email}]]\n:END:")
	))

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;;;
(defadvice org-capture-finalize 
    (after delete-capture-frame activate)  
  "Advise capture-finalize to close the frame"  
  (if (equal "capture" (frame-parameter nil 'name))  
      (delete-frame)))

(defadvice org-capture-destroy 
    (after delete-capture-frame activate)  
  "Advise capture-destroy to close the frame"  
  (if (equal "capture" (frame-parameter nil 'name))  
      (delete-frame)))  

(defun make-capture-frame ()
  "Create a new frame and run org-capture."
  (interactive)
  (make-frame '((name . "capture")))
  (select-frame-by-name "capture")
  (delete-other-windows))
