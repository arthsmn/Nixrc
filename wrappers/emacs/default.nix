{pkgs, ...}: {
  wrappers.emacs = {
    basePackage = pkgs.emacsWithPackagesFromUsePackage {
      config = ./config/init.el;
      package = pkgs.emacs29-pgtk;
      extraEmacsPackages = epkgs: [pkgs.eglot-booster];
    };
    flags = [
      "--init-directory"
      ./config
    ];
    pathAdd = with pkgs; [emacs-lsp-booster];
  };
}
