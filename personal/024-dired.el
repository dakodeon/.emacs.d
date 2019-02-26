;; peep-dired / ranger / image dired
(define-key dired-mode-map "P" 'peep-dired)
(define-key dired-mode-map "R" 'ranger-mode)
(define-key dired-mode-map "r" 'dired-do-rename)
;; (define-key dired-mode-map "C-S-t" (lambda () (interactive) 'image-dired-show-all-from-dir "."))

;; image dired 
(setq image-dired-thumb-width 250)
(setq image-dired-thumbs-per-row 4)
(setq image-dired-external-viewer "sxiv")

;; ranger
(setq ranger-show-literal nil)
(setq ranger-show-hidden nil)
(setq ranger-dont-show-binary t)
(setq ranger-cleanup-on-disable t)
