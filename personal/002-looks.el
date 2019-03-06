;; === LOOKS

;; disable splash
(setq inhibit-splash-screen t
      initial-scratch-message nil)

;; disable bars
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; theme setting
;; (load-theme 'darkokai t)
(require 'color-theme-sanityinc-tomorrow)
(color-theme-sanityinc-tomorrow--define-theme bright)

;; rainbow mode
(add-hook 'prog-mode-hook 'rainbow-mode)

;; highlight lines
(global-hl-line-mode t)
(set-face-background 'hl-line "#151515")
