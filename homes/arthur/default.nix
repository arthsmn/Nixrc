{outputs, ...}: {
  imports =
    [
      ./dconf.nix
      ./emacs
      ./misc.nix
      ./shell.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);
}
