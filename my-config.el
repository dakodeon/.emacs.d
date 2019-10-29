(use-package try
  :ensure t)

(setq inhibit-splash-screen t)       ;; disable the splash screen
(setq initial-scratch-message nil)   ;; disable scratch message
(tool-bar-mode -1)                   ;; all bars off
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(column-number-mode 1)               ;; show cursor position
(global-visual-line-mode t)          ;; visual line mode everywhere
(global-hl-line-mode t)              ;; highlight active line
;; (set-face-background ('hl-line) "#202020")
(fset 'yes-or-no-p 'y-or-n-p)        ;; ask me for y or n
(setq select-enable-clipboard t)     ;; use the clipboard for yanking
(setq save-interprogram-paste-before-kill t)
(setq help-window-select t)          ;; always focus on help windows
(setq sentence-end-double-space nil) ;; better sentence navigation
(delete-selection-mode 1)            ;; typing deletes selected text
(set-language-environment "UTF-8")   ;; always use UTF-8 encoding
(set-default-coding-systems 'utf-8)

(put 'downcase-region 'disabled nil) ;; binds to 'C-x C-l'
(put 'upcase-region 'disabled nil) ;; binds to 'C-x C-u'
(put 'narrow-to-region 'disabled nil) ;; binds to 'C-x n n'

(global-set-key (kbd "C-<next>") 'text-scale-increase)
(global-set-key (kbd "C-<prior>") 'text-scale-decrease)

(display-line-numbers-mode t)

(use-package linum-relative
  :ensure t
  :init
  (setq linum-relative-current-symbol "")
  :bind ("C-x M-l" . linum-relative-toggle))

(use-package darkroom
  :ensure t
  :init
  (setq darkroom-text-scale-increase 0.8)
  :bind
  (("C-M-_" . darkroom-decrease-margins)
   ("C-x M-D" . darkroom-tentative-mode)))

(global-set-key (kbd "C-x M-L") 'follow-mode)

(use-package rainbow-mode
  :ensure t
  :hook prog-mode)

(use-package color-theme-sanityinc-tomorrow
  :ensure t)

(color-theme-sanityinc-tomorrow--define-theme bright)

(use-package which-key
  :ensure t
  :config (which-key-mode))

;; use separate custom file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; backup files
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t) ;; this is to ensure all edited files keep their inodes

(global-set-key (kbd "C-x C-S-e") 'eval-buffer)

(global-set-key (kbd "C-;") 'comment-line)
(global-set-key (kbd "C-M-;") 'comment-or-uncomment-region)

(use-package smartparens-config
  :ensure smartparens
  :init
  (smartparens-global-mode 1)
  (show-smartparens-global-mode 1)
  :bind
  ("M-s" . sp-splice-sexp))

(use-package rainbow-delimiters
  :ensure t
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package expand-region
  :ensure t
  :bind
  (("C-=" . er/expand-region)
   ("C-c =" . er/expand-region)
   ("C--" . er/contract-region)
   ("C-c -" . er/contract-region)))

(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key [remap move-beginning-of-line] 'smarter-move-beginning-of-line)

(global-set-key (kbd "C-S-k") 'kill-whole-line)

(defun duplicate-line()
  "Duplicates a line."
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))

(global-set-key (kbd "C-c d") 'duplicate-line)

(windmove-default-keybindings) ;; use arrow keys ot navigate

;; resize shortcuts
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

(use-package ace-window
  :ensure t
  :bind
  (("C-x o" . ace-window)
   ("C-x M-o" . ace-swap-window)))

(defun split-and-follow-horizontally ()
  "Split and follow container horizontally."
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))

(defun split-and-follow-vertically ()
  "Split and follow container vertically."
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))

(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

(defun toggle-window-split ()
  "Switch between horizontal and vertical split when using two windows."
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))

(global-set-key (kbd "C-x |") 'toggle-window-split)

(global-set-key (kbd "C-x \\") 'window-swap-states)

(use-package helm-config
  :ensure helm
  :defer 1
  :init
  (setq helm-follow-mode-persistent t)
  (setq  helm-split-window-inside-p t)
  :config
  (helm-mode 1)
  :bind
  (("M-x" . helm-M-x)
   ("C-x C-f" . helm-find-files)
   ([remap switch-to-buffer] . helm-buffers-list)))

(use-package swoop
  :ensure t
  :init
  (setq swoop-font-size-change: nil)
  :bind
  (("C-S" . swoop)
   ("C-R" . swoop-back-to-last-position)
   :map swoop-map
   ("C-o" . swoop-multi-from-swoop)
   :map isearch-mode-map
   ("C-o" . swoop-from-isearch)))

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    (setq ac-sources (append ac-sources '(ac-sources-filename)))
    (setq ac-ignore-case nil)))

(use-package multiple-cursors
  :ensure t
  :bind
  ("C-s-c C-s-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C-<" . mc/mark-all-like-this)
  ("C-<down-mouse-1>" . mc/add-cursor-on-click)
  ("C-!" . mc/insert-numbers))

(use-package mc-extras
  :ensure t
  :after multiple-cursors)

(use-package ace-mc
  :ensure t
  :after multiple-cursors
  :bind
  ("C-c )" . ace-mc-add-multiple-cursors)
  ("C-M-)" . ace-mc-add-single-cursor))

(setq image-dired-thumb-width 250)
(setq image-dired-thumbs-per-row 4)
(setq image-dired-external-viewer "sxiv")

(use-package peep-dired
  :ensure t
  :after dired
  :bind
  (:map dired-mode-map
	("P" . peep-dired)))

(use-package ranger
  :ensure t
  :after dired
  :init
  (setq ranger-show-literal nil)
  (setq ranger-show-hidden nil)
  (setq ranger-dont-show-binary t)
  (setq ranger-cleanup-on-disable t)
  :bind
  (:map dired-mode-map
	("r" . dired-do-rename)
	("R" . ranger-mode)))

(unless (package-installed-p 'org-plus-contrib)
  (package-refresh-contents)
  (package-install 'org-plus-contrib))

;; prettify
(setq org-hide-leading-stars t)

;; src options
(require 'org-tempo)

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-confirm-babel-evaluate nil)
(setq org-edit-src-content-indentation 0)

;; export options -- for mail html export (fix it locally!)
(setq org-export-with-toc nil)
(setq org-export-with-section-numbers nil)

;; files
(setq org-directory "~/.personal")
(setq org-default-notes-file (concat org-directory "/organizer.org"))

;; TODOs
(setq org-log-done 'time)
(setq org-log-into-drawer 'LOGBOOK)
(setq org-clock-into-drawer t)

;; bindings
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

;; some capture functions from Zamansky's configuration
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

;; (use-package evil-org
;;   :ensure t
;;   :after org
;;   :config
;;   (add-hook 'org-mode-hook 'evil-org-mode)
;;   (add-hook 'evil-org-mode-hook
;; 	    (lambda ()
;; 	      (evil-org-set-key-theme)))
;;   (require 'evil-org-agenda)
;;   (evil-org-agenda-set-keys))

(setq TeX-parse-self t)
(setq-default TeX-master nil)

;; === run xelatex on save for latex mode
(defun latex-save-compile ()
  "Compile file after saving in latex mode. Using Xelatex."
  (when (eq major-mode 'latex-mode)
    (when (memq this-command '(save-buffer))
      (shell-command-to-string (format "xelatex %s" buffer-file-name)))))

(add-hook 'after-save-hook #'latex-save-compile)

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(require 'mu4e)

(global-set-key (kbd "C-x m") 'mu4e)

;; some interface options
(setq mu4e-confirm-quit nil)
(setq message-kill-buffer-on-exit t)
(setq mu4e-index-update-in-background t)
(setq mu4e-hide-index-messages t)
(setq mu4e-headers-include-related nil)
(setq mu4e-compose-dont-reply-to-self nil)
(setq mu4e-compose-signature-auto-include nil)
(setq mu4e-sent-messages-behavior 'sent)
(setq mu4e-change-filenames-when-moving t)
(setq mu4e-attachment-dir "~/Downloads")
(setq mu4e-show-images t)
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(add-to-list 'mu4e-view-actions '("ViewInBrowser" . mu4e-action-view-in-browser) t)

(setq mu4e-user-mail-address-list '("loukas.bass@gmx.com"
				    "dakodeon@hotmail.com"
				    "freehuggs701@gmail.com"))

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

(setq mu4e-get-mail-command "mbsync -a")
(setq mu4e-html2text-command "w3m -T text/html")
(setq mu4e-update-interval 60)
(setq mu4e-headers-auto-update t)

(setq mu4e-maildir (expand-file-name "~/.personal/Mail"))

;; default directories
(setq mu4e-drafts-folder "/loukas.bass/Drafts")
(setq mu4e-sent-folder "/loukas.bass/Sent")
(setq mu4e-trash-folder "/loukas.bass/Trash")

;; maildirs shortcuts
(setq mu4e-maildir-shortcuts
      '( ("/Inbox" . ?i)
	 ("/loukas.bass/Inbox" . ?l)
	 ("/loukas.bass/Sent" . ?s)
	 ("/loukas.bass/Trash" . ?t)
	 ("/loukas.bass/Drafts" . ?D)
	 ("/gmail/Inbox" . ?g)
	 ("/dakodeon/Inbox" . ?d)))

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

(require 'org-mu4e)
(setq org-mu4e-convert-to-html t)
(define-key mu4e-compose-mode-map (kbd "M-c") 'org-mu4e-compose-org-mode)

(defun mu4e-open-in-headers (account)
  "Open mu4e in account's Inbox"
  (interactive)
  (mu4e~start)
  (if (get-buffer "*mu4e-headers*" )
      (switch-to-buffer "*mu4e-headers*"))
  (mu4e-headers-search (concat "maildir:/" account "/Inbox")))

(add-hook 'mu4e-index-updated-hook
	  (defun mu4e-signal-i3blocks ()
	    (shell-command "pkill -RTMIN+2 i3blocks")))

(add-hook 'mu4e-view-mode-hook 'mu4e-signal-i3blocks)

(mu4e~start)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil
  :ensure t
  :init
  (setq evil-move-cursor-back nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-fine-undo t)
  (setq evil-normal-state-cursor 'box)
  (setq evil-emacs-state-cursor 'bar)
  (setq evil-replace-state-cursor 'hbar)
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config 
  (evil-set-initial-state 'Info-mode 'emacs)
  (evil-set-initial-state 'org-capture-mode 'insert)
  (evil-set-initial-state 'mu4e-compose-mode 'insert)
  (evil-set-initial-state 'dired-mode 'emacs)
  (evil-define-state emacs
    "Emacs used as insert state in evil."
    :tag " <EE> "
    :message "-- EMACS INSERT --"
    :input-method t)
  (defadvice evil-insert-state (around emacs-state-instead-of-insert-state activate) (evil-emacs-state))
  (evil-mode 1)
  :bind
  (:map evil-normal-state-map
	("j" . 'evil-next-visual-line)
	("k" . 'evil-previous-visual-line)
	("^" . 'evil-beginning-of-visual-line)
	("$" . 'evil-end-of-visual-line)
	("g ^" . 'evil-beginning-of-line)
	("g $" . 'evil-end-of-line)
	([down] . 'evil-next-visual-line)
	([up] . 'evil-previous-visual-line)
	:map evil-emacs-state-map
	([escape] . 'evil-normal-state)))

(defun goto-file-or-dir (f)
  "Find the given file. If file is a directory, do helm-find-file there"
  (if (file-directory-p f)
      (helm-find-files-1 f)
    (if (file-exists-p f)
	(find-file f))))

;; create a prefix
(define-prefix-command 'z-map)
(global-set-key (kbd "C-x g") 'z-map)

(define-key z-map (kbd "E") (lambda () (interactive) (goto-file-or-dir "~/.emacs.d/init.el")))
(define-key z-map (kbd "e") (lambda () (interactive) (goto-file-or-dir "~/.emacs.d/my-config.org")))
(define-key z-map (kbd "i") (lambda () (interactive) (goto-file-or-dir "~/.config/i3/i3.conf")))
(define-key z-map (kbd "r") (lambda () (interactive) (goto-file-or-dir "~/.config/ranger/rc.conf")))
(define-key z-map (kbd "x") (lambda () (interactive) (goto-file-or-dir "~/.Xresources")))
(define-key z-map (kbd "z") (lambda () (interactive) (goto-file-or-dir "~/.zshrc")))
(define-key z-map (kbd "h") (lambda () (interactive) (goto-file-or-dir "~/")))
(define-key z-map (kbd "P") (lambda () (interactive) (goto-file-or-dir "~/Pictures/")))
(define-key z-map (kbd "p") (lambda () (interactive) (goto-file-or-dir "~/.personal/")))
(define-key z-map (kbd "C") (lambda () (interactive) (goto-file-or-dir "~/.config/")))
(define-key z-map (kbd "D") (lambda () (interactive) (goto-file-or-dir "~/Downloads/")))
(define-key z-map (kbd "d") (lambda () (interactive) (goto-file-or-dir "~/Documents/")))
(define-key z-map (kbd "c") (lambda () (interactive) (goto-file-or-dir "~/dotfiles/")))
(define-key z-map (kbd "S") (lambda () (interactive) (goto-file-or-dir "~/.config/scripts/")))
