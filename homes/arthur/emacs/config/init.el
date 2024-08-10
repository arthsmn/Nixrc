;; -*- lexical-binding: t -*-
(use-package emacs
  :custom
  (backup-directory-alist `((".*" . ,temporary-file-directory)))
  (auto-save-list-file-prefix nil)
  (auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
  (custom-file (make-temp-file "emacs-custom-"))

  (sentence-end-double-space nil)

  (read-extended-command-predicate #'command-completion-default-include-p)

  :bind (("C-<return>" . toggle-frame-fullscreen)
         ("C-c r" . meow-query-replace-regexp)))

(use-package no-littering :ensure t
  :config (let ((dir (no-littering-expand-etc-file-name "lock-files/")))
            (make-directory dir t)
            (setopt lock-file-name-transforms `((".*" ,dir t)))))

(use-package auto-revert
  :custom
  (auto-revert-avoid-polling t)
  (auto-revert-interval 5)
  (auto-revert-check-vc-info t)
  :hook (after-init . global-auto-revert-mode))

(use-package savehist-mode
  :custom (history-delete-duplicates t)
  :hook (after-init . savehist-mode))

(use-package subword-mode
  :hook (prog-mode . subword-mode))

(set-face-attribute 'default nil :family "Iosevka Comfy")
(set-face-attribute 'variable-pitch nil :family "Iosevka Comfy Motion")

(use-package ligature :ensure t
  :hook (prog-mode . ligature-mode)
  :config (ligature-set-ligatures 'prog-mode '("<---" "<--"  "<<-" "<-" "->" "-->" "--->" "<->" "<-->" "<--->" "<---->" "<!--"
                                               "<==" "<===" "<=" "=>" "=>>" "==>" "===>" ">=" "<=>" "<==>" "<===>" "<====>" "<!---"
                                               "<~~" "<~" "~>" "~~>" "::" ":::" "==" "!=" "===" "!=="
                                               ":=" ":-" ":+" "<*" "<*>" "*>" "<|" "<|>" "|>" "+:" "-:" "=:" "<******>" "++" "+++")))

(use-package textsize :ensure t
  :if (display-graphic-p)
  :hook (after-init . textsize-mode))

(use-package visual-line-mode
  :hook ((text-mode prog-mode) . visual-line-mode))

(use-package context-menu-mode
  :if (display-graphic-p)
  :hook (after-init . context-menu-mode))

(use-package pixel-scroll-precision-mode
  :hook (after-init . pixel-scroll-precision-mode))

(use-package which-key
  :hook (after-init . which-key-mode))

(use-package delsel
  :hook (after-init . delete-selection-mode))

(use-package enlight :ensure t
  :preface (autoload 'enlight-menu "enlight-menu" nil t)
  :config
  (setopt enlight-content (concat
                           (propertize "    Emacs" 'face '(italic :height 200))
                           "\n\n"
                           (enlight-menu
                            '(("Arquivos"
	                       ("Projetos" project-switch-project "p")
	                       ("Arquivos Recentes" recentf-open "r")))))
          initial-buffer-choice #'enlight))

(use-package auto-dark :ensure t
  :custom
  (auto-dark-dark-theme 'modus-vivendi)
  (auto-dark-light-theme 'modus-operandi)
  :config (auto-dark-mode))

(use-package spacious-padding :ensure t
  :hook (after-init . spacious-padding-mode)
  :bind ("<f8>" . spacious-padding-mode))

(use-package mood-line :ensure t
  :hook (after-init . mood-line-mode))

(use-package helpful :ensure t
  :bind (("C-h f" . helpful-callable)
         ("C-h C-f" . helpful-callable)
         ("C-h F" . helpful-function)
         ("C-h C-F" . helpful-function)
         ("C-h M-f" . view-emacs-FAQ)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-h x" . helpful-command)
         ("C-c C-d" . helpful-at-point)))

(use-package ace-window :ensure t
  :custom (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind ("M-o" . ace-window))

(use-package electric-pair
  :hook (prog-mode . electric-pair-mode))

(use-package dtrt-indent :ensure t
  :hook (prog-mode . dtrt-indent-mode))

(use-package aggressive-indent :ensure t
  :hook (prog-mode . aggressive-indent-mode))

(use-package whitespace-cleanup-mode :ensure t
  :hook ((text-mode prog-mode) . whitespace-cleanup-mode))

(use-package rainbow-delimiters :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package colorful-mode :ensure t
  :custom (colorful-use-prefix t)
  :config (add-to-list 'colorful-extra-color-keyword-functions '(colorful-add-rgb-colors))
  :hook (prog-mode . colorful-mode))

(use-package treesit-auto :ensure t
  :hook (prog-mode . treesit-auto-mode)
  :config (treesit-auto-add-to-auto-mode-alist 'all))

(use-package eat :ensure t
  :bind ("C-c e" . eat-other-window)
  :custom (eat-kill-buffer-on-exit t)
  :config
  (eat-eshell-mode)
  (eat-eshell-visual-command-mode))

(use-package eglot
  :hook ((c-ts-mode
          nix-ts-mode
          fennel-mode
          nix-mode
          haskell-mode
          rust-ts-mode) . eglot-ensure)
  :custom
  (eglot-autoshutdown t)
  (eglot-send-changes-idle-time 0.1)
  (eglot-extend-to-xref t)
  :config
  (fset #'jsonrpc--log-event #'ignore)
  (add-to-list 'eglot-server-programs
               '(nix-ts-mode . ("nixd")))
  (add-to-list 'eglot-server-programs
               '(fennel-mode . ("fennel-ls")))
  )
(use-package eglot-booster :after eglot
  :config (eglot-booster-mode))

(use-package sly :ensure t
  :custom (inferior-lisp-program "sbcl"))

(use-package markdown-mode :ensure t
  :mode "\\.md\\'")

(use-package nix-mode :ensure t
  :mode "\\.nix\\'")

(use-package nix-drv-mode :after nix-mode
  :mode "\\.drv\\'")

;; WAIT FOR: https://github.com/nix-community/nix-ts-mode/issues/39
;; (use-package nix-ts-mode
;;   :ensure t 
;;   :mode "\\.nix\\'"
;; )

(use-package haskell-mode-autoloads :ensure haskell-mode)

(use-package fish-mode :ensure t
  :mode "\\.fish\\'")

(use-package fennel-mode :ensure t
  :mode "\\.fnl\\'")

(use-package corfu :ensure t
  :hook (after-init . global-corfu-mode)
  :custom
  (completion-auto-help 'always)
  (completion-auto-select 'second-tab)
  (completion-cycle-threshold 1)
  (completions-detailed t)
  (completions-max-height 20)
  (enable-recursive-minibuffers t)
  (tab-always-indent 'complete)
  (text-mode-ispell-word-completion nil)
  :init (keymap-set minibuffer-mode-map "TAB" 'minibuffer-complete))

(use-package corfu-popupinfo :after corfu
  :hook (corfu-mode . corfu-popupinfo-mode)
  :custom
  (corfu-popupinfo-delay '(0.25 . 0.1))
  (corfu-popupinfo-hide nil)
  :config (corfu-popupinfo-mode))

(use-package corfu-terminal :ensure t :after corfu
  :if (not (display-graphic-p))
  :config (corfu-terminal-mode))

(use-package cape :ensure t ;; TODO: explorar
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

(use-package kind-icon  :ensure t  :after corfu
  :if (display-graphic-p)
  :config (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package orderless :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package vertico :ensure t
  :hook (after-init . vertico-mode))

(use-package vertico-grid :after vertico)

(use-package vertico-multiform :after (vertico-grid)
  :hook (vertico-mode . vertico-multiform-mode)
  :config (add-to-list 'vertico-multiform-categories
                       '(jinx grid (vertico-grid-annotate . 20))))

(use-package vertico-directory :after vertico
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; :hook (rfn-eshadow-update-overlay . vertico-directory-tidy)
  )


(use-package marginalia :ensure t
  :hook (after-init . marginalia-mode))

(use-package consult :ensure t
  :custom
  (consult-narrow-key "<")
  :bind (
         ;; Drop-in replacements
         ("C-x b" . consult-buffer)
         ("C-x C-b" . consult-buffer)
         ("M-y"   . consult-yank-pop)
         ;; Searching
         ("M-s r" . consult-ripgrep)
	 ("M-s f" . consult-fd)
         ("C-s" . consult-line)
         ("C-S-s" . consult-outline)
         ("M-s l" . consult-line-multi)
         ;; Isearch integration
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)
         ("M-s e" . consult-isearch-history)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)))

(use-package embark :ensure t
  :bind (("C-." . embark-act)
         ("C-;" . embark-dwim)
         ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :custom (prefix-help-command #'embark-prefix-help-command)
  :config (add-to-list 'display-buffer-alist
                       '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                         nil
                         (window-parameters (mode-line-format . none)))))

(use-package embark-consult :ensure t
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package dired
  :custom
  (dired-recursive-copies 'always)
  (dired-recursive-deletes 'always)
  (delete-by-moving-to-trash t)
  (dired-listing-switches
   "-AGFhl --group-directories-first"))

(use-package eshell
  :init (defun my/setup-eshell ()
          ;; Something funny is going on with how Eshell sets up its keymaps; this is
          ;; a work-around to make C-r bound in the keymap
          (keymap-set eshell-mode-map "C-r" 'consult-history))
  :hook ((eshell-mode . my/setup-eshell)))

(use-package magit :ensure t
  :bind ("C-x g" . magit-status))

(use-package jinx :ensure t
  :hook (text-mode . jinx-mode)
  :bind (("M-#" . jinx-correct)
         ("C-M-#" . jinx-languages))
  :custom (jinx-languages "pt_BR en_US"))

(use-package org
  :hook
  (org-mode . org-indent-mode)
  (org-mode . variable-pitch-mode))

(use-package org-auto-tangle :ensure t
  :after org
  :hook (org-mode . org-auto-tangle-mode))

(use-package pdf-tools :ensure t
  :mode ("\\.pdf\\'" . pdf-view-mode))

(use-package visual-fill-column :ensure t
  :custom
  (visual-fill-column-center-text t)
  (visual-fill-column-width 80))

(use-package nov :ensure t
  :custom (nov-text-width t)
  :hook (nov-mode . visual-line-fill-column-mode)
  :mode ("\\.epub\\'" . nov-mode))

;;;
;;; Meow
;;;
(use-package meow :ensure t
  :config
  (defun meow-setup ()
    (setopt meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
    (meow-motion-overwrite-define-key
     '("j" . meow-next)
     '("k" . meow-prev)
     '("<escape>" . ignore))
    (meow-leader-define-key
     ;; SPC j/k will run the original command in MOTION state.
     '("j" . "H-j")
     '("k" . "H-k")
     ;; Use SPC (0-9) for digit arguments.
     '("1" . meow-digit-argument)
     '("2" . meow-digit-argument)
     '("3" . meow-digit-argument)
     '("4" . meow-digit-argument)
     '("5" . meow-digit-argument)
     '("6" . meow-digit-argument)
     '("7" . meow-digit-argument)
     '("8" . meow-digit-argument)
     '("9" . meow-digit-argument)
     '("0" . meow-digit-argument)

     '(";" . comment-line)
     
     '("/" . meow-keypad-describe-key)
     '("?" . meow-cheatsheet))
    (meow-normal-define-key
     '("0" . meow-expand-0)
     '("9" . meow-expand-9)
     '("8" . meow-expand-8)
     '("7" . meow-expand-7)
     '("6" . meow-expand-6)
     '("5" . meow-expand-5)
     '("4" . meow-expand-4)
     '("3" . meow-expand-3)
     '("2" . meow-expand-2)
     '("1" . meow-expand-1)
     '("-" . negative-argument)
     '(";" . meow-reverse)
     '("," . meow-inner-of-thing)
     '("." . meow-bounds-of-thing)
     '("[" . meow-beginning-of-thing)
     '("]" . meow-end-of-thing)
     '("a" . meow-append)
     '("A" . meow-open-below)
     '("b" . meow-back-word)
     '("B" . meow-back-symbol)
     '("c" . meow-change)
     '("d" . meow-delete)
     '("D" . meow-backward-delete)
     '("e" . meow-next-word)
     '("E" . meow-next-symbol)
     '("f" . meow-find)
     '("g" . meow-cancel-selection)
     '("G" . meow-grab)
     '("h" . meow-left)
     '("H" . meow-left-expand)
     '("i" . meow-insert)
     '("I" . meow-open-above)
     '("j" . meow-next)
     '("J" . meow-next-expand)
     '("k" . meow-prev)
     '("K" . meow-prev-expand)
     '("l" . meow-right)
     '("L" . meow-right-expand)
     '("m" . meow-join)
     '("n" . meow-search)
     '("o" . meow-block)
     '("O" . meow-to-block)
     '("p" . meow-yank)
     '("q" . meow-quit)
     '("Q" . meow-goto-line)
     '("r" . meow-replace)
     '("R" . meow-swap-sgrab)
     '("s" . meow-kill)
     '("t" . meow-till)
     '("u" . meow-undo)
     '("U" . meow-undo-in-selection)
     '("v" . meow-visit)
     '("w" . meow-mark-word)
     '("W" . meow-mark-symbol)
     '("x" . meow-line)
     '("X" . meow-goto-line)
     '("y" . meow-save)
     '("Y" . meow-sync-grab)
     '("z" . meow-pop-selection)
     '("'" . repeat)
     '("<escape>" . ignore)
     ))
  :hook
  (after-init . meow-setup)
  (after-init . meow-global-mode))

(use-package meow-tree-sitter :ensure t
  :after meow
  :config (meow-tree-sitter-register-defaults))


(use-package gcmh :ensure t
  :custom
  (gcmh-idle-delay 5)
  (gcmh-high-cons-threshold (* 256 1024 1024))
  (gcmh-verbose init-file-debug)
  :hook (after-init . gcmh-mode))
