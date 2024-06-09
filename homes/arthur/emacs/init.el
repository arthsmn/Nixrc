;;; Package --- Minha configuração
;;; Commentary:
;;; Code:

(use-package emacs-tweaks
  :custom (display-line-numbers-type 'relative)
  (default-frame-alist '((font . "Sarasa Mono CL 15")))
  (make-backup-files nil)
  (auto-save-default nil)
  (create-lockfiles nil)

  (auto-dark-dark-theme 'modus-vivendi)
  (auto-dark-light-theme 'modus-operandi) ;; auto-dark
  (wgrep-auto-save-buffer t) ;; wgrep
  (completion-styles '(orderless)) ;; orderless
  (org-hide-emphasis-markers t)
  (org-pretty-entities t)
  (org-modern-star 'replace)
  :hook (prog-mode . electric-pair-mode)
  (prog-mode . display-line-numbers-mode)
  (tree-sitter-after-on . tree-sitter-hl-mode)
  :init (pixel-scroll-precision-mode)
  (blink-cursor-mode nil)
  (global-prettify-symbols-mode)
  (global-tree-sitter-mode)
  (savehist-mode)

  (auto-dark-mode) ;; auto-dark
  (global-aggressive-indent-mode) ;; aggressive-indent
  (which-key-mode) ;; which-key
  (pdf-loader-install) ;; pdf-tools
  (ligature-set-ligatures 'prog-mode '("<---" "<--"  "<<-" "<-" "->" "-->" "--->" "<->" "<-->" "<--->" "<---->" "<!--"
				       "<==" "<===" "<=" "=>" "=>>" "==>" "===>" ">=" "<=>" "<==>" "<===>" "<====>" "<!---"
				       "<~~" "<~" "~>" "~~>" "::" ":::" "==" "!=" "===" "!=="
				       ":=" ":-" ":+" "<*" "<*>" "*>" "<|" "<|>" "|>" "+:" "-:" "=:" "<******>" "++" "+++"))
  (global-ligature-mode) ;; ligature.el
  (marginalia-mode) ;; marginalia
  (with-eval-after-load 'org (global-org-modern-mode)) ;; org-modern
  :bind ("M-o" . ace-window) ;; ace-window
  ("C-c j" . avy-goto-line)
  ("s-j"   . avy-goto-char-timer) ;; avy
  )

(use-package dashboard
  :custom
  (dashboard-center-content t)
  (initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))
  :config (dashboard-setup-startup-hook))

(use-package eglot-booster :after eglot :config (eglot-booster-mode))

(use-package eglot
  :config
  (setq completion-category-overrides '((eglot (styles orderless))
					(eglot-capf (styles orderless))))
  
  (advice-add 'eglot-completion-at-point :around #'cape-wrap-buster)
  
  (defun my/eglot-capf ()
    (setq-local completion-at-point-functions
		(list (cape-capf-super
		       #'eglot-completion-at-point
		       ;; #'tempel-expand
		       #'cape-file))))
  (add-hook 'eglot-managed-mode-hook #'my/eglot-capf)
  :hook (haskell-mode . eglot-ensure)
  (nix-mode . eglot-ensure))

(use-package nov
  :mode "\\.epub\\'"
  :init (defun my-nov-font-setup ()
	  (face-remap-add-relative 'variable-pitch :family "DejaVu Serif"
				   :height 0.85))
  (setq nov-text-width t
	visual-fill-column-center-text t)
  :hook (nov-mode . my-nov-font-setup)
  (nov-mode . visual-line-mode)
  (nov-mode . visual-fill-column-mode))

(use-package consult
  :bind (
         ;; Drop-in replacements
         ("C-x b" . consult-buffer)     ; orig. switch-to-buffer
         ("M-y"   . consult-yank-pop)   ; orig. yank-pop
         ;; Searching
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)       ; Alternative: rebind C-s to use
         ("M-s s" . consult-line)       ; consult-line instead of isearch, bind
         ("M-s L" . consult-line-multi) ; isearch to M-s s
         ("M-s o" . consult-outline)
         ;; Isearch integration
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)   ; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history) ; orig. isearch-edit-string
         ("M-s l" . consult-line)            ; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)      ; needed by consult-line to detect isearch
         )
  :config (setq consult-narrow-key "<"))

(use-package embark
  :after avy
  :bind (("C-c a" . embark-act))
  :init
  (defun my/avy-action-embark (pt)
    (unwind-protect
        (save-excursion
          (goto-char pt)
          (embark-act))
      (select-window
       (cdr (ring-ref avy-ring 0))))
    t)

  (setf (alist-get ?. avy-dispatch-alist) 'my/avy-action-embark))

(use-package vertico
  :init (vertico-mode))

(use-package vertico-directory
  :after vertico
  :bind (:map vertico-map
              ("M-DEL" . vertico-directory-delete-word)))

(use-package corfu
  :init (global-corfu-mode)
  :custom (corfu-auto t)
  :bind (:map corfu-map
	      ("SPC" . corfu-insert-separator)
	      ("C-n" . corfu-next)
	      ("C-p" . corfu-previous)))

(use-package corfu-popupinfo
  :after corfu
  :hook (corfu-mode . corfu-popupinfo-mode)
  :custom
  (corfu-popupinfo-delay '(0.25 . 0.1))
  (corfu-popupinfo-hide nil)
  :config (corfu-popupinfo-mode))

(use-package corfu-terminal
  :if (not (display-graphic-p))
  :config (corfu-terminal-mode))

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

(use-package kind-icon
  :if (display-graphic-p)
  :after corfu
  :config (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package eshell
  :init (defun my/setup-eshell ()
	  (keymap-set eshell-mode-map "C-r" 'consult-history))
  :hook ((eshell-mode . my/setup-eshell)))

(use-package nix-mode :mode "\\.nix\\'")

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(if (not (file-exists-p custom-file))
    (make-empty-file custom-file))
(load custom-file)
;;; init.el ends here
