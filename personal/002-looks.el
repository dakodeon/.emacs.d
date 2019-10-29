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
(set-face-background 'hl-line "#202020")

;; darkroom options
(setq darkroom-text-scale-increase 0.8)

;; seems more sensible to do use _ instead of -
(global-set-key (kbd "C-M-_") 'darkroom-decrease-margins)

(global-set-key (kbd "C-x M-D") 'darkroom-tentative-mode)

