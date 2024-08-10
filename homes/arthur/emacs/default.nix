{pkgs, ...}: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs-pgtk;
      config = ./config.org;
      alwaysTangle = true;
      extraEmacsPackages = epkgs: [
        epkgs.treesit-grammars.with-all-grammars
        pkgs.eglot-booster
      ];
    };
  };

  services.emacs = {
    enable = true;
    client.enable = true;
  };

  home.packages = with pkgs; [
    emacs-lsp-booster
  ];

  xdg.configFile.emacs.source = ./config;
}
