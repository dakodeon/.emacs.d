;; expand/contract regions -- also to work in terminal mode

(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-c =") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)
(global-set-key (kbd "C-c -") 'er/contract-region)
