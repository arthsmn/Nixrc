{
  lib,
  pkgs,
  config,
  ...
}: {
  programs.emacs = {
    enable = false;
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
        modus-themes
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
        org-modern-indent
      ]);
    extraConfig = lib.concatStringsSep "\n" (map (path: lib.readFile path) [
      ./sanity.el
      ./builtins.el
      ./completion.el
      ./dashboard.el
      ./documents.el
      ./misc.el
      ./lsp.el
    ]);
  };

  services.emacs.enable = config.programs.emacs.enable;
}
