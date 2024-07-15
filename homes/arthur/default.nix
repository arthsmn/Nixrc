{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      ./dconf.nix
      ./helix.nix
      ./irc.nix
      ./misc.nix
      ./mpv.nix
      ./secrets.nix
      ./shell.nix
      ./term.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules)
    ++ [
      inputs.hyprcursor-phinger.homeManagerModules.hyprcursor-phinger
      inputs.sops-nix.homeManagerModules.sops
      inputs.ghostty-hm-module.homeModules.default
      inputs.ags.homeManagerModules.default
    ];
}
