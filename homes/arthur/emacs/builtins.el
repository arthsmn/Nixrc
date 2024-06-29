;; electric-pair
(add-hook 'prog-mode-hook 'electric-pair-mode)

;; line-numbers
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; font
(setopt default-frame-alist '((font . "Sarasa Mono CL 15")))

;; unique buffer names
(require 'uniquify)

;; context menu
(when (display-graphic-p)
  (context-menu-mode))

;; text wrapping
(add-hook 'text-mode-hook 'visual-line-mode)

;; modernization
(setopt sentence-end-double-space nil)

;; tree-sitter
(add-hook 'tree-sitter-after-on-hook 'tree-sitter-hl-mode)
(add-hook 'after-init-hook 'global-tree-sitter-mode)

;; org-mode
(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'flyspell-mode)

;; prettify symbols
(global-prettify-symbols-mode)
