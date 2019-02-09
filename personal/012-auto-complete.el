;; auto-completion

(ac-config-default)
(setq global-auto-complete-mode 1)
(setq ac-sources (append ac-sources '(ac-source-filename)))
(setq ac-ignore-case nil)
