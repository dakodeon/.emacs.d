;; === LaTeX (AUCTEX)

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;; === run xelatex on save for latex mode
(defun latex-save-compile ()
  "Compile file after saving in latex mode. Using Xelatex."
  (when (eq major-mode 'latex-mode)
    (when (memq this-command '(save-buffer))
      (shell-command-to-string (format "xelatex %s" buffer-file-name)))))

(add-hook 'after-save-hook #'latex-save-compile)
