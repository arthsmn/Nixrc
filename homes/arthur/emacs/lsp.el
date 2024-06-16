(with-eval-after-load 'eglot (eglot-booster-mode))

(setopt
 completion-category-overrides '((eglot (styles orderless))
				 (eglot-capf (styles orderless)))
 eglot-extend-to-xref t)

(advice-add 'eglot-completion-at-point :around #'cape-wrap-buster)

(defun my/eglot-capf ()
  (setq-local completion-at-point-functions
	      (list (cape-capf-super
		     #'eglot-completion-at-point
		     ;; #'tempel-expand
		     #'cape-file))))
(add-hook 'eglot-managed-mode-hook #'my/eglot-capf)

(fset #'jsonrpc--log-event #'ignore)

(add-hook 'nix-mode-hook 'eglot-ensure)
(add-hook 'haskell-mode-hook 'eglot-ensure)
