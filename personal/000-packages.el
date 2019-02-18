;; === PACKAGE MANAGEMENT
(require 'package)
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))

(package-initialize)

;; add here any packages you want by default
(defvar louk/packages '(smartparens
			ace-window
			multiple-cursors
			mc-extras
			ace-mc
			linum-relative
			expand-region
			org-plus-contrib
			auto-complete
			yasnippet
			yasnippet-snippets
			helm
			swoop
			which-key
			rainbow-mode)
  "Default packages")

(defun louk/packages-installed-p ()
  (cl-loop for pkg in louk/packages
	when (not (package-installed-p pkg)) do (cl-return nil)
	finally (cl-return t)))

(unless (louk/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg louk/packages)
    (when (not (package-installed-p pkg))
            (package-install pkg))))
