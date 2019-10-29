;; === PARENTHESES HANDLING

;; smartparens
(smartparens-global-mode)
(show-smartparens-mode t)
(require 'smartparens-config)

;; remove enclosing brackets
(global-set-key (kbd "M-s") 'sp-splice-sexp)

;; rainbow delimiters for programming modes
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
