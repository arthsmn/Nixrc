;; auto-dark-emacs
(use-package auto-dark
  :custom
  (auto-dark-dark-theme 'modus-vivendi)
  (auto-dark-light-theme 'modus-operandi)
  :config
  (auto-dark-mode t))

;; aggressive-indent
(global-aggressive-indent-mode)

;; which-key
(which-key-mode)

;; ligatures
(ligature-set-ligatures 'prog-mode '("<---" "<--"  "<<-" "<-" "->" "-->" "--->" "<->" "<-->" "<--->" "<---->" "<!--"
				     "<==" "<===" "<=" "=>" "=>>" "==>" "===>" ">=" "<=>" "<==>" "<===>" "<====>" "<!---"
				     "<~~" "<~" "~>" "~~>" "::" ":::" "==" "!=" "===" "!=="
				     ":=" ":-" ":+" "<*" "<*>" "*>" "<|" "<|>" "|>" "+:" "-:" "=:" "<******>" "++" "+++"))
(global-ligature-mode)

;; org-modern
(setopt
 org-hide-emphasis-markers t
 org-pretty-entities t
 org-modern-star 'replace)
(with-eval-after-load 'org (global-org-modern-mode))
(require 'org-modern-indent)
(add-hook 'org-mode-hook #'org-modern-indent-mode 90)

;; whitespace cleanup
(add-hook 'prog-mode-hook #'whitespace-cleanup-mode)

;; empv
(setopt empv-invidious-instance "https://vid.puffyan.us/api/v1")
(bind-key "C-x m" empv-map)

;; nix-mode
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

;; colorful-mode
(setopt colorful-use-prefix t)
(add-hook 'prog-mode-hook #'colorful-mode)

;; diff-hl
(global-diff-hl-mode)
(diff-hl-flydiff-mode)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode-unless-remote)
(add-hook 'magit-pre-refresh-hook 'diff-hl-magit-pre-refresh)
(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

;; bindings
(bind-key "M-o" 'ace-window)
(bind-key "C-c j" 'avy-goto-line)
(bind-key "s-j" 'avy-goto-char-timer)
(bind-key "C-x g" 'magit-status)
(bind-key "C-x v t" 'vterm-other-window)
(global-set-key (kbd "M-<escape>") #'god-local-mode)
