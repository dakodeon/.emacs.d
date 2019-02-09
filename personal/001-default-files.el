;; === DEFAULT FILES

;; use separate custom file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; backup files
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t)
