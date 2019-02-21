;; multiple cursors

(global-set-key (kbd "C-s-c C-s-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;;(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "C-<down-mouse-1>") 'mc/add-cursor-on-click)

(global-set-key (kbd "C-!") 'mc/insert-numbers)

;; ;;mc-extras
;; (define-key mc/keymap (kbd "C-. C-d") 'mc/remove-current-cursor)
;; (define-key mc/keymap (kbd "C-. d")   'mc/remove-duplicated-cursors)

;; (define-key mc/keymap (kbd "C-. C-.") 'mc/freeze-fake-cursors-dwim)

;; (define-key mc/keymap (kbd "C-. =")   'mc/compare-chars)

;; ace-mc
(global-set-key (kbd "C-c )") 'ace-mc-add-multiple-cursors)
(global-set-key (kbd "C-M-)") 'ace-mc-add-single-cursor)
