;; init.el

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")))

(package-initialize)
;; (package-refresh-contents)

;; Bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; (setq use-package-debug t)
;; (setq use-package-verbose t)

(org-babel-load-file (expand-file-name "~/.emacs.d/my-config.org"))
