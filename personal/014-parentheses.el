;; === PARENTHESES HANDLING

;; smartparens
(require 'smartparens-config)
(smartparens-global-mode t)
(show-smartparens-mode t)

;; remove enclosing brackets
(global-set-key (kbd "M-s") 'sp-splice-sexp)

;; rainbow delimiters for programming modes
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
