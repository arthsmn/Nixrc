{outputs, ...}: {
  imports =
    [
      ./dconf.nix
      ./misc.nix
      ./shell.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);
}
