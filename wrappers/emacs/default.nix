{pkgs, ...}: {
  wrappers.emacs = {
    basePackage = pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs-pgtk;
      config = ./config.org;
      alwaysTangle = true;
      extraEmacsPackages = epkgs: [
        epkgs.treesit-grammars.with-all-grammars
        pkgs.eglot-booster
      ];
    };

    flags = [
      "--init-directory"
      ./.config
    ];

    pathAdd = with pkgs; [emacs-lsp-booster];
  };
}
