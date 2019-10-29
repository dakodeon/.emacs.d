;; evil mode -- because sometimes I feel a bit evil!

(evil-mode 1)

;; start in emacs mode
;; (setq evil-default-state 'emacs)

;; cursor does not move back when exiting insert mode
(setq evil-move-cursor-back nil)

;; C-u moves up (like vim)
(setq evil-want-C-u-scroll t)

;; Change the way undo works
(setq evil-want-fine-undo t)

;; change some keys for visual mode
(define-key evil-normal-state-map "j" 'evil-next-visual-line)
(define-key evil-normal-state-map "k" 'evil-previous-visual-line)
(define-key evil-normal-state-map "^" 'evil-beginning-of-visual-line)
(define-key evil-normal-state-map "$" 'evil-end-of-visual-line)
(define-key evil-normal-state-map "g ^" 'evil-beginning-of-line)
(define-key evil-normal-state-map "g $" 'evil-end-of-line)

;; change the default state for several modes
(evil-set-initial-state 'Info-mode 'emacs)
(evil-set-initial-state 'org-capture-mode 'insert)
(evil-set-initial-state 'mu4e-compose-mode 'insert)
(evil-set-initial-state 'dired-mode 'emacs)

;; evil-mu4e
(require 'evil-mu4e)
