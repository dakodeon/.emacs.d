;; better search with swoop

(require 'swoop)

(global-set-key (kbd "C-S-s") 'swoop)
(global-set-key (kbd "C-S-r") 'swoop-back-to-last-position)

(define-key swoop-map (kbd "C-o") 'swoop-multi-from-swoop)
(define-key isearch-mode-map (kbd "C-o") 'swoop-from-isearch)

(setq swoop-font-size-change: nil)
