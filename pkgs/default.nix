pkgs: {
  nextvi = pkgs.callPackage ./nextvi {};
  sf-mono-liga-bin = pkgs.callPackage ./sf-mono-liga-bin {};
  lime3ds = pkgs.callPackage ./lime3ds {};
  justify-kp = pkgs.callPackage ./justify-kp {
    inherit (pkgs.emacsPackages) trivialBuild dash-functional s;
  };
  eglot-booster = pkgs.callPackage ./eglot-booster {
    inherit (pkgs.emacsPackages) trivialBuild seq jsonrpc eglot;
  };
}
