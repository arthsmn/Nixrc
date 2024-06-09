{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      ./dconf.nix
      ./emacs
      ./helix.nix
      ./irc.nix
      ./misc.nix
      ./mpv.nix
      ./secrets.nix
      ./shell.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules)
    ++ [inputs.sops-nix.homeManagerModules.sops inputs.ghostty-hm-module.homeModules.default];
}
