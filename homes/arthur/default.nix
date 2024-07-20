{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      ./dconf.nix
      ./misc.nix
      ./secrets.nix
      ./shell.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules)
    ++ [
      inputs.sops-nix.homeManagerModules.sops
    ];
}
