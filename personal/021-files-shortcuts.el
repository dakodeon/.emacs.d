;; shortcuts to a bunch of files and folders

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
(define-key z-map (kbd "e") (lambda () (interactive) (goto-file-or-dir "~/.emacs.d/personal/")))
(define-key z-map (kbd "i") (lambda () (interactive) (goto-file-or-dir "~/.config/i3/i3.conf")))
(define-key z-map (kbd "r") (lambda () (interactive) (goto-file-or-dir "~/.config/ranger/rc.conf")))
(define-key z-map (kbd "x") (lambda () (interactive) (goto-file-or-dir "~/.Xresources")))
(define-key z-map (kbd "z") (lambda () (interactive) (goto-file-or-dir "~/.zshrc")))
(define-key z-map (kbd "h") (lambda () (interactive) (goto-file-or-dir "~/")))
(define-key z-map (kbd "p") (lambda () (interactive) (goto-file-or-dir "~/Pictures/")))
(define-key z-map (kbd "P") (lambda () (interactive) (goto-file-or-dir "~/.personal")))
(define-key z-map (kbd "C") (lambda () (interactive) (goto-file-or-dir "~/.config/")))
(define-key z-map (kbd "D") (lambda () (interactive) (goto-file-or-dir "~/Downloads/")))
(define-key z-map (kbd "d") (lambda () (interactive) (goto-file-or-dir "~/Documents/")))
