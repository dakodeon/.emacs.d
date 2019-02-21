;; === HELM

(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)

(global-set-key (kbd "C-x C-f") 'helm-find-files)

(setq helm-follow-mode-persistent t)

(setq helm-split-window-inside-p t)

(global-set-key [remap switch-to-buffer] 'helm-buffers-list)
