;;; Package --- Minha configuração
;;; Commentary:
;;; Code:

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(if (not (file-exists-p custom-file))
    (make-empty-file custom-file))
(load custom-file)

(use-package emacs-tweaks
  :custom ((display-line-numbers-type 'relative)
	   (default-frame-alist '((font . "Sarasa Mono CL 15")))
	   (backup-directory-alist . `((".*" . ,temporary-file-directory)))
	   (auto-save-file-name-transforms . `((".*" ,temporary-file-directory t))))
  :hook ((prog-mode . electric-pair-mode)
	 (prog-mode . display-line-numbers-mode))
  :config (global-prettify-symbols-mode +1))

(use-package which-key
  :config (which-key-mode))

(use-package dashboard
  :config (dashboard-setup-startup-hook))
(setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name))
      dashboard-center-content t)

(use-package vterm
  :defer 5)

(use-package adwaita-dark-theme
  :config (load-theme 'adwaita-dark t))

(use-package aggressive-indent
  :defer 3
  :config (global-aggressive-indent-mode 1))

(use-package company
  :config (global-company-mode))

(use-package ligature
  :config
  (ligature-set-ligatures 'prog-mode '("<---" "<--"  "<<-" "<-" "->" "-->" "--->" "<->" "<-->" "<--->" "<---->" "<!--"
				       "<==" "<===" "<=" "=>" "=>>" "==>" "===>" ">=" "<=>" "<==>" "<===>" "<====>" "<!---"
				       "<~~" "<~" "~>" "~~>" "::" ":::" "==" "!=" "===" "!=="
				       ":=" ":-" ":+" "<*" "<*>" "*>" "<|" "<|>" "|>" "+:" "-:" "=:" "<******>" "++" "+++"))
  (global-ligature-mode t))

(use-package flycheck
  :defer 3
  :hook (after-init . global-flycheck-mode))

(use-package eglot-booster
  :after eglot
  :config (eglot-booster-mode))

(use-package flycheck-eglot
  :ensure t
  :after (flycheck eglot)
  :config
  (global-flycheck-eglot-mode 1))

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

;; org-modern
(with-eval-after-load 'org (global-org-modern-mode))
(setq
 org-hide-emphasis-markers t
 org-pretty-entities t
 org-modern-star 'replace)

(use-package pdf-tools
  :defer 3
  :config (pdf-loader-install))

(use-package tree-sitter
  :defer 3
  :config (global-tree-sitter-mode)
  :hook (tree-sitter-after-on . tree-sitter-hl-mode))

(use-package nix-mode
  :mode "\\.nix\\'"
  :hook (nix-mode . eglot-ensure))

(use-package haskell-mode
  :hook ((haskell-mode . eglot-ensure)
	 (haskell-mode . (lambda ()
			   (set (make-local-variable 'company-backends)
				(append '((company-capf company-dabbrev-code))
					company-backends))))))
;;; init.el ends here
