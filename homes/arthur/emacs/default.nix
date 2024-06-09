{lib, pkgs, ...}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = (epkgs: (with epkgs; [
      ace-window
      aggressive-indent
      auto-dark
      avy
      cape
      consult
      corfu
      corfu-terminal
      dashboard
      embark
      embark-consult
      haskell-mode
      kind-icon
      ligature
      marginalia
      markdown-mode
      nix-mode
      nov
      orderless
      org-modern
      pdf-tools
      tree-sitter-langs
      vertico
      visual-fill-column
      vterm
      wgrep
      which-key
    ]) ++ (with pkgs;[
      #justify-kp
      eglot-booster
    ]));
    extraConfig = lib.readFile ./init.el;
  };
  
  services.emacs.enable = true;
  
  xdg.configFile."emacs/early-init.el".text = lib.readFile ./early-init.el;
}
