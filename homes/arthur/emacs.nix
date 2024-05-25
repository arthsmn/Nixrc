{lib, pkgs, ...}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraConfig = ''
      (menu-bar-mode -1)
      (tool-bar-mode -1)
      (scroll-bar-mode -1)
      (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
      (load custom-file)
      (add-to-list 'default-frame-alist '(fullscreen . maximized))
      (set-face-attribute 'default t :font "Sarasa Mono CL 13")
      (setq make-backup-files nil)

      (require 'vterm)

      (require 'dashboard)
      (dashboard-setup-startup-hook)
      (setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))

      (require 'which-key)
      (which-key-mode)

      (require 'smartparens-config)
      (add-hook 'prog-mode-hook #'smartparens-mode)
      (add-hook 'text-mode-hook #'smartparens-mode)
      (add-hook 'markdown-mode-hook #'smartparens-mode)

      (require 'tree-sitter)
      (require 'tree-sitter-langs)
      (global-tree-sitter-mode)
      (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

      (require 'rainbow-delimiters)
      (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

      (require 'sly)
      (setq inferior-lisp-program "${lib.getExe pkgs.sbcl}")
      
      (require 'helpful)
      (global-set-key (kbd "C-h f") #'helpful-callable)
      (global-set-key (kbd "C-h v") #'helpful-variable)
      (global-set-key (kbd "C-h k") #'helpful-key)
      (global-set-key (kbd "C-h x") #'helpful-command)
      (global-set-key (kbd "C-c C-d") #'helpful-at-point)
      (global-set-key (kbd "C-h F") #'helpful-function)

      (require 'flycheck)
      (global-flycheck-mode +1)

      (require 'company)
      (add-hook 'after-init-hook #'global-company-mode)

      (require 'lsp-mode)
      (add-hook 'nix-mode-hook #'lsp)
'     (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)

      (require 'nix-mode)
      (add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))
    '';
    extraPackages = epkgs:
      with epkgs; [
        adwaita-dark-theme
        company
        dashboard
        flycheck
        helpful
        lsp-mode
        lsp-ui
        nix-mode
        rainbow-delimiters
        sly
        smartparens
        tree-sitter-langs
        vterm
        which-key
      ];
  };

  xdg.configFile."emacs/early-init.el".text = ''
    (setq inhibit-startup-message t)
    (setq package-enable-at-startup nil)
  '';
}
