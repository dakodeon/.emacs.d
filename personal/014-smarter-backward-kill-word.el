;; smarter backward kill word -- needs revising

;; (defun smarter-backward-kill-word ()
;;   (interactive)
;;   (cond 
;;    ((looking-back (rx (char word)) 1)
;;     (backward-kill-word 1))
;;    ((looking-back (rx (char blank)) 1)
;;     (delete-horizontal-space t))
;;    (t
;;     (backward-delete-char 1))))
(defun smarter-backward-kill-word ()
  (interactive)
  (if (bolp)
      (backward-delete-char 1)
    (if (string-match "[^[:space:]]" (buffer-substring (point-at-bol) (point)))
	(if (looking-back "\\s(\\|\\s[")
	    (progn
	      (backward-delete-char 1)
	      (delete-horizontal-space t))
	  (backward-kill-word 1))
      (delete-horizontal-space t))))

(global-set-key [C-backspace] 'smarter-backward-kill-word)
