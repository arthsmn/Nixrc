{pkgs, ...}: {
  nextvi = pkgs.callPackage ./nextvi {};
  sf-mono-liga-bin = pkgs.callPackage ./sf-mono-liga-bin {};
}
