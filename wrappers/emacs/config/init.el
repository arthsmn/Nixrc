;; init.el --- Configuration -*- lexical-binding: t; -*-

(use-package gcmh :ensure t
  :custom
  (gcmh-idle-delay 5)
  (gcmh-high-cons-threshold (* 16 1024 1024)) ;; 16 MB
  (gcmh-verbose init-file-debug)
  :hook (after-init . gcmh-mode))

(use-package no-littering :ensure t :demand t
  :config
  (let ((dir (no-littering-expand-var-file-name "lock-files/")))
    (make-directory dir t)
    (setopt lock-file-name-transforms `((".*" ,dir t))))
  (setopt custom-file (no-littering-expand-var-file-name "custom.el"))
  (load custom-file 'noerror)
  :hook (after-init . (lambda () (load custom-file 'noerror))))

(use-package emacs :ensure nil
  :custom
  ;; colocar backups e auto-saves no /tmp
  (backup-directory-alist `((".*" . ,temporary-file-directory)))
  (auto-save-list-file-prefix nil)
  (auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))

  ;; número das linhas de forma relativa
  (display-line-numbers-type 'relative)

  ;; padrão arcaico
  (sentence-end-double-space nil)

  ;; opções para o auto-revert
  (auto-revert-avoid-polling t)
  (auto-revert-interval 5)
  (auto-revert-check-vc-info t)

  (cursor-type 'bar)
  :config
  ;; lê o arquivo do disco automaticamente quando modificado
  (global-auto-revert-mode)

  ;; melhoras na UI
  (blink-cursor-mode -1)
  (pixel-scroll-precision-mode)
  (when (display-graphic-p) (context-menu-mode))

  ;; salvar histórico do minibuffer
  (savehist-mode)
  :hook
  ;; autocompletar pares
  (prog-mode . electric-pair-mode)
  
  (prog-mode . display-line-numbers-mode)
  (text-mode . visual-line-mode)
  (prog-mode . visual-line-mode)
  :bind (
	 ("C-<return>" . toggle-frame-fullscreen)))

;;;
;;; Plugins para melhorar a  UI
;;;
(use-package which-key :ensure t :config (which-key-mode))

(use-package enlight :ensure t
  :preface (autoload 'enlight-menu "enlight-menu" nil t)
  :custom
  (enlight-content
   (concat
    (propertize "    Emacs" 'face '(italic :height 200))
    "\n\n"
    (enlight-menu
     '(
       ;; ("Org Mode"
       ;;  ("Org-Agenda (current day)" (org-agenda nil "a") "a"))
       ("Arquivos"
	("Projetos" project-switch-project "p")
	("Arquivos Recentes" recentf-open "r"))
       ))
    ))
  (initial-buffer-choice #'enlight))

(unless (or (daemonp) (display-graphic-p)) (load-theme 'modus-vivendi))
(use-package auto-dark :ensure t
  :if (or (display-graphic-p) (daemonp))
  :custom
  (auto-dark-dark-theme 'modus-vivendi)
  (auto-dark-light-theme 'modus-operandi)
  :config (auto-dark-mode))

(use-package mood-line :ensure t
  :config (mood-line-mode))

(use-package textsize :ensure t ;; ajusta o tamanho do texto de acordo com as dimensões da tela
  :if (display-graphic-p)
  :config (textsize-mode))

(use-package helpful :ensure t
  :bind (("C-h f" . helpful-callable)   ;; melhor documentação
         ("C-h C-f" . helpful-callable)
         ("C-h F" . helpful-function)
         ("C-h C-F" . helpful-function)
         ("C-h M-f" . view-emacs-FAQ)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)
         ("C-h x" . helpful-command)
         ("C-c C-d" . helpful-at-point)))

;;;
;;; Plugins de desenvolvimento
;;;
(use-package dtrt-indent :ensure t ;; tenta advinhar o estilo de indentação
  :config (dtrt-indent-global-mode))

(use-package aggressive-indent :ensure t
  :config
  (global-aggressive-indent-mode 1))

(use-package hungry-delete :ensure t
  ;; :custom (hungry-delete-join-reluctantly t)
  :config (global-hungry-delete-mode))

(use-package whitespace-cleanup-mode :ensure t :config (global-whitespace-cleanup-mode))

(use-package magit :ensure t :defer t :bind ("C-x g" . magit-status))

(use-package rainbow-delimiters :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package colorful-mode :ensure t
  :custom
  (colorful-use-prefix t)
  :config
  (add-to-list 'colorful-extra-color-keyword-functions '(colorful-add-rgb-colors))
  (global-colorful-mode))

(use-package eat :ensure t
  :bind ("C-c e" . eat)
  :custom
  (eat-term-name "xterm")
  (eat-kill-buffer-on-exit t)
  :config
  (eat-eshell-mode)
  (eat-eshell-visual-command-mode))

(use-package eglot
  :hook
  ((c-mode nix-mode) . eglot-ensure)
  :custom
  (eglot-send-changes-idle-time 0.1)
  (eglot-extend-to-xref t)
  :config
  (fset #'jsonrpc--log-event #'ignore))
(use-package eglot-booster :after eglot :config (eglot-booster-mode)) ;; pacote customizado

(use-package markdown-mode :ensure t)

(use-package nix-mode :ensure t :mode "\\.nix\\'")

;;;
;;; Completar no ponto
;;;
(keymap-set minibuffer-mode-map "TAB" 'minibuffer-complete) ; TAB acts more like how it does in the shell
(setopt enable-recursive-minibuffers t)                ; Use the minibuffer whilst in the minibuffer
(setopt completion-cycle-threshold 1)                  ; TAB cycles candidates
(setopt completions-detailed t)                        ; Show annotations
(setopt tab-always-indent 'complete)                   ; When I hit TAB, try to complete, otherwise, indent
;; (setopt completion-styles '(basic initials substring)) ; Different styles to match input to candidates
(setopt completion-auto-help 'always)                  ; Open completion always; `lazy' another option
(setopt completions-max-height 20)                     ; This is arbitrary
(setopt completions-detailed t)
(setopt completions-format 'one-column)
(setopt completions-group t)
(setopt completion-auto-select 'second-tab)            ; Much more eager
;;(setopt completion-auto-select t)                     ; See `C-h v completion-auto-select' for more possible values

;; (require 'corfu)
(use-package corfu :ensure t
  :hook
  (after-init . global-corfu-mode)
  :bind
  (:map corfu-map
        ("SPC" . corfu-insert-separator)
        ("C-n" . corfu-next)
        ("C-p" . corfu-previous)))

(use-package corfu-popupinfo :after corfu
  :hook (corfu-mode . corfu-popupinfo-mode)
  :custom
  (corfu-popupinfo-delay '(0.25 . 0.1))
  (corfu-popupinfo-hide nil)
  :config (corfu-popupinfo-mode))

(use-package corfu-terminal  :ensure t
  :if (not (display-graphic-p))
  :config (corfu-terminal-mode))

(use-package cape :ensure t ;; TODO: explorar
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file))

(use-package kind-icon  :ensure t  :after corfu
  :if (display-graphic-p)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package orderless :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;;;
;;; Minibuffer + pesquisa
;;;
(use-package vertico :ensure t :hook (after-init . vertico-mode))

(use-package vertico-directory :after vertico
  :bind (:map vertico-map
              ("M-DEL" . vertico-directory-delete-word)))

(use-package marginalia :ensure t
  :config (marginalia-mode))

(use-package consult
  :ensure t
  :custom (consult-narrow-key "<")
  :bind (
         ;; Drop-in replacements
         ("C-x b" . consult-buffer)     ; orig. switch-to-buffer
         ("C-x C-b" . consult-buffer)     ; orig. switch-to-buffer
         ("M-y"   . consult-yank-pop)   ; orig. yank-pop
         ;; Searching
         ("M-s r" . consult-ripgrep)
	 ("M-s f" . consult-fd)
         ("C-s" . consult-line)       ; Alternative: rebind C-s to use
         ("M-s s" . consult-line)       ; consult-line instead of isearch, bind
         ("M-s L" . consult-line-multi) ; isearch to M-s s
         ("M-s o" . consult-outline)
         ;; Isearch integration
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)   ; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history) ; orig. isearch-edit-string
         ("M-s l" . consult-line)            ; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)      ; needed by consult-line to detect isearch
         ))

(use-package eshell
  :init
  (defun my/setup-eshell ()
    ;; Something funny is going on with how Eshell sets up its keymaps; this is
    ;; a work-around to make C-r bound in the keymap
    (keymap-set eshell-mode-map "C-r" 'consult-history))
  :hook ((eshell-mode . my/setup-eshell)))

(use-package wgrep
  :ensure t
  :config
  (setq wgrep-auto-save-buffer t))

;;;
;;; Plugins gerais
;;;
(use-package restart-emacs :ensure t)

(use-package empv :ensure t
  :custom (empv-invidious-instance "https://vid.puffyan.us/api/v1")
  :bind-keymap ("C-c m" . empv-map))

(use-package org
  :hook
  (org-mode . flyspell-mode)
  (org-mode . org-indent-mode))

(use-package pdf-tools :ensure t
  :mode ("\\.pdf\\'" . pdf-view-mode))

(use-package visual-fill-column :ensure t)
(use-package nov :ensure t
  :custom
  (nov-text-width t)
  (visual-fill-column-center-text t)
  :hook
  (nov-mode . visual-line-mode)
  (nov-mode . visual-fill-column-mode)
  :mode ("\\.epub\\'" . nov-mode))

;;;
;;; Meow
;;;
(use-package meow :ensure t
  :config
  (defun meow-setup ()
    (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
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
  (meow-setup)
  (meow-global-mode 1))
