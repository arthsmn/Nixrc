;; nov.el
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(defun my-nov-font-setup ()
  (face-remap-add-relative 'variable-pitch :family "DejaVu Serif"
			   :height 0.85))
(add-hook 'nov-mode-hook 'my-nov-font-setup)

(setopt nov-text-width t
	visual-fill-column-center-text t)
(add-hook 'nov-mode-hook 'visual-line-mode)
(add-hook 'nov-mode-hook 'visual-fill-column-mode)

;; pdf-tools
(pdf-loader-install)
