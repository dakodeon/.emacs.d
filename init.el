;; init.el

;; load all personal configuration

;; (defun load-directory (dir)
;;       (let ((load-it (lambda (f)
;; 		       (load-file (concat (file-name-as-directory dir) f)))
;; 		     ))
;; 	(mapc load-it (directory-files dir nil "\\.el$"))))
;; (load-directory "~/.emacs.d/personal/")

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")
			 ;; ("melpa" . "http://melpa.milkbox.net/packages/")
			 ("org" . "http://orgmode.org/elpa/")))

(package-initialize)
;; (package-refresh-contents)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(setq use-package-debug t)
(setq use-package-verbose t)

(org-babel-load-file (expand-file-name "~/.emacs.d/my-config.org"))
