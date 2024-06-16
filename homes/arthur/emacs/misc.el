;; auto-dark-mode
(setopt
 auto-dark-dark-theme 'modus-vivendi
 auto-dark-light-theme 'modus-vivendi)
(auto-dark-mode)

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

;; empv
(setopt empv-invidious-instance "https://vid.puffyan.us/api/v1")
(bind-key "C-x m" empv-map)

;; nix-mode

(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

;; bindings
(bind-key "M-o" 'ace-window)
(bind-key "C-c j" 'avy-goto-line)
(bind-key "s-j" 'avy-goto-char-timer)
(bind-key "C-x g" 'magit-status)
