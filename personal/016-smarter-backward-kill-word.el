;; smarter backward kill word -- needs revising

(defun smarter-backward-kill-word ()
  (interactive)
  (cond 
   ((looking-back (rx (char word)) 1)
    (backward-kill-word 1))
   ((looking-back (rx (char blank)) 1)
    (delete-horizontal-space t))
   (t
    (backward-delete-char 1))))

(global-set-key [remap backward-kill-word] 'smarter-backward-kill-word)
