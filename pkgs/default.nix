pkgs: {
  sf-mono-liga-bin = pkgs.callPackage ./sf-mono-liga-bin {};
  material-black-colors-theme = pkgs.callPackage ./material-black-colors-theme {};

  justify-kp = pkgs.callPackage ./justify-kp {
    inherit (pkgs.emacsPackages) trivialBuild dash-functional s;
  };
  eglot-booster = pkgs.callPackage ./eglot-booster {
    inherit (pkgs.emacsPackages) trivialBuild seq jsonrpc eglot;
  };
  org-modern-indent = pkgs.callPackage ./org-modern-indent {
    inherit (pkgs.emacsPackages) trivialBuild org compat;
  };
  eglot-x = pkgs.callPackage ./eglot-x {
    inherit (pkgs.emacsPackages) trivialBuild project xref eglot;
  };
}
