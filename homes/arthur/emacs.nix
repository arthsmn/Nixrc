{lib, pkgs, ...}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = (epkgs: (with epkgs; [
      which-key
      vterm
      nix-mode
      haskell-mode
      kaolin-themes
      aggressive-indent
      dashboard
      ligature
      nov
      visual-fill-column
      org-modern
      pdf-tools
      adwaita-dark-theme
      flycheck
      flycheck-eglot
      company
      tree-sitter-langs
      markdown-mode
    ]) ++ (with pkgs;[
      #justify-kp
      eglot-booster
    ]));
    extraConfig = lib.readFile ./init.el;
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
  };
  
  xdg.configFile."emacs/early-init.el".text = ''
    (setq inhibit-startup-message t)
    (setenv "LSP_USE_PLISTS" "true")
  '';
}
