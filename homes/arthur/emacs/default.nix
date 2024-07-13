{
  lib,
  pkgs,
  config,
  ...
}: {
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
        colorful-mode
        consult
        corfu
        corfu-terminal
        dashboard
        diff-hl
        embark
        embark-consult
        empv
        god-mode
        haskell-mode
        julia-mode
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
        restart-emacs
        rust-mode
        sly
        tree-sitter-langs
        vertico
        visual-fill-column
        vterm
        wgrep
        which-key
        whitespace-cleanup-mode
        ])
        ++ (with pkgs; [
          # justify-kp
          eglot-booster
          org-modern-indent
        ]);
      extraConfig = with lib; concatStringsSep "\n" (map (path: readFile path) [
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
