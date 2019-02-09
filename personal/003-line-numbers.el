;; === LINE NUMBERING

;; display line numbers
(display-line-numbers-mode)

;; relative numbers
;; (linum-relative-global-mode 1)
(global-set-key (kbd "C-x M-l") 'linum-relative-toggle)
(setq linum-relative-current-symbol "")
