{
  lib,
  pkgs,
  ...
}: let
  configPaths = [ ./sanity.el ./builtins.el ./completion.el ./dashboard.el ./documents.el ./misc.el ./lsp.el ];
in {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    extraPackages = epkgs:
      (with epkgs; [
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
        empv
        haskell-mode
        kind-icon
        ligature
        magit
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
      ])
      ++ (with pkgs; [
        #justify-kp
        eglot-booster
      ]);
    extraConfig = lib.concatStringsSep "\n" (map (path: lib.readFile path) configPaths);
  };
  
    services.emacs.enable = true;

    # xdg.configFile."emacs/early-init.el".text = lib.readFile ./early-init.el;
}
