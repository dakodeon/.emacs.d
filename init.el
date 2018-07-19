;; init.el

;; ;; Load all customization files in alphabetical order
;; (mapcar (lambda (path)
;; 	  (add-to-list 'load-path (concat path "/")))
;; 	(file-expand-wildcards "~/.emacs.d/init-snippets/*.el"))

;; === PACKAGE MANAGEMENT
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; add here any packages you want by default
(defvar louk/packages '(smartparens
			ace-window
			multiple-cursors
			mc-extras
			ace-mc
			linum-relative
			expand-region)
  "Default packages")

(defun louk/packages-installed-p ()
  (cl-loop for pkg in louk/packages
	when (not (package-installed-p pkg)) do (cl-return nil)
	finally (cl-return t)))

(unless (louk/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg louk/packages)
    (when (not (package-installed-p pkg))
            (package-install pkg))))

;; === DEFAULT FILES
;; use separate custom file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; backup files
(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)

;; === WINDOWS
;; easier switching of windows
(windmove-default-keybindings)

;; resize shortcuts
(global-set-key (kbd "s-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "s-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "s-C-<down>") 'shrink-window)
(global-set-key (kbd "s-C-<up>") 'enlarge-window)

;; ace window by default
;; This overrides the default "C-x o" action
(global-set-key (kbd "C-x o") 'ace-window)
(global-set-key (kbd "C-x M-o") 'ace-swap-window)

;; split windows and follow
;; overrides the default behaviour of "C-x 2" and "C-x 3"
(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

;; toggle window split
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
         (next-win-buffer (window-buffer (next-window)))
         (this-win-edges (window-edges (selected-window)))
         (next-win-edges (window-edges (next-window)))
         (this-win-2nd (not (and (<= (car this-win-edges)
                     (car next-win-edges))
                     (<= (cadr this-win-edges)
                     (cadr next-win-edges)))))
         (splitter
          (if (= (car this-win-edges)
             (car (window-edges (next-window))))
          'split-window-horizontally
        'split-window-vertically)))
    (delete-other-windows)
    (let ((first-win (selected-window)))
      (funcall splitter)
      (if this-win-2nd (other-window 1))
      (set-window-buffer (selected-window) this-win-buffer)
      (set-window-buffer (next-window) next-win-buffer)
      (select-window first-win)
      (if this-win-2nd (other-window 1))))))

(global-set-key (kbd "C-x \\") 'toggle-window-split)

;; === TEXT EDIT AND CODE
;; show parens
;; (show-paren-mode t)
(show-smartparens-mode t)

;; smartparens
(smartparens-global-mode t)

;; remove enclosing brackets
(global-set-key (kbd "M-s") 'sp-splice-sexp)

;; expand regions
(global-set-key (kbd "C-=") 'er/expand-region)

;; rainbow delimiters for programming modes
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; line numbers
(linum-relative-global-mode 1)
(global-set-key (kbd "C-x M-l") 'linum-relative-toggle)
(setq linum-relative-current-symbol "")

;; use follow mode
(follow-mode t)

;; comment - uncomment lines and regions
(global-set-key (kbd "C-;") 'comment-line)
(global-set-key (kbd "C-M-;") 'comment-or-uncomment-region)

;; multiple cursors
(global-set-key (kbd "C-s-c C-s-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;;(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "C-<down-mouse-1>") 'mc/add-cursor-on-click)

;; ;;mc-extras
;; (define-key mc/keymap (kbd "C-. C-d") 'mc/remove-current-cursor)
;; (define-key mc/keymap (kbd "C-. d")   'mc/remove-duplicated-cursors)

;; (define-key mc/keymap (kbd "C-. C-.") 'mc/freeze-fake-cursors-dwim)

;; (define-key mc/keymap (kbd "C-. =")   'mc/compare-chars)

;; ace-mc
(global-set-key (kbd "C-c )") 'ace-mc-add-multiple-cursors)
(global-set-key (kbd "C-M-)") 'ace-mc-add-single-cursor)

;; === LOOKS
;; disable splash
(setq inhibit-splash-screen t
      initial-scratch-message nil)

;; bars
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; visual line mode
(global-visual-line-mode t)

;; ido vertical
(ido-mode 1)
(ido-vertical-mode 1)

;; theme setting
(load-theme 'darkokai t)
