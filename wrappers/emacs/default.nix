{pkgs, ...}: {
  wrappers.emacs = {
    basePackage = pkgs.emacsWithPackagesFromUsePackage {
      config = ./config.org;
      alwaysTangle = true;
      package = pkgs.emacs-pgtk;
      extraEmacsPackages = epkgs: [
        pkgs.eglot-booster
        epkgs.treesit-grammars.with-all-grammars
      ];
    };
    flags = [
      "--init-directory"
      ./.config
    ];
    pathAdd = with pkgs; [emacs-lsp-booster];
  };
}
