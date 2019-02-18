;; change defaults for font size
(global-set-key (kbd "C-<next>") 'text-scale-increase)
(global-set-key (kbd "C-<prior>") 'text-scale-decrease)

;; always focus on help windows
(setq help-window-select t)

;; use clipboard
(setq select-enable-clipboard t)

;; these are disabled by default, but I want them
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

;; visual line mode
(global-visual-line-mode t)

;; show cursor position on text
(column-number-mode 1)

;; disable yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; enable which-key mode
(which-key-mode)
