(setopt
 read-extended-command-predicate 'command-completion-default-include-p
 wgrep-auto-save-buffer t
 completion-styles '(orderless))

(marginalia-mode)

(use-package consult
  :bind (
	 ("C-x b" . consult-buffer)     ; orig. switch-to-buffer
	 ("M-y"   . consult-yank-pop)   ; orig. yank-pop
	 ;; Searching
	 ("M-s r" . consult-ripgrep)
	 ("M-s f" . consult-fd)
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
  (corfu-preselect 'directory)
  (tab-always-indent 'complete)
  (corfu-quit-no-match 'separator)
  :bind
  (:map corfu-map ("RET" . nil)))

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
