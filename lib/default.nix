{nixpkgs, ...}: let
  lib = nixpkgs.lib;
in {
  forAllSystems = let
    systems = [
      # "aarch64-linux"
      # "i686-linux"
      "x86_64-linux"
      # "aarch64-darwin"
      # "x86_64-darwin"
    ];
  in
    lib.genAttrs systems;

  listOfDirs = path:
    lib.pipe (builtins.readDir path) [
      (lib.filterAttrs (name: value: value == "directory"))
      builtins.attrNames
      (map (n: /${path}/${n}))
    ];
}
