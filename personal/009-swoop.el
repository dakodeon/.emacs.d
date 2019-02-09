;; better search with swoop

(require 'swoop)
(global-set-key (kbd "C-s") 'swoop)
(global-set-key (kbd "C-S-s") 'swoop-multi)
(global-set-key (kbd "C-c s") 'swoop-back-to-last-position)

(define-key swoop-map (kbd "C-o") 'swoop-multi-from-swoop)

(setq swoop-font-size-change: nil)
