;; === LOOKS

;; disable splash
(setq inhibit-splash-screen t
      initial-scratch-message nil)

;; disable bars
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; visual line mode
(global-visual-line-mode t)

;; theme setting
(load-theme 'darkokai t)
