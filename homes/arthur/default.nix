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
      ./hyprland.nix
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
      inputs.sops-nix.homeManagerModules.sops inputs.ghostty-hm-module.homeModules.default
    ];
}
