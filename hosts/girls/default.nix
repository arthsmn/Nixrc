{outputs, ...}: {
  imports =
    [
      ./basicSetup.nix
      ./disko.nix
      ./hardware.nix
      ./networking.nix
      ./nix.nix
      ./secrets.nix
      ./users.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);
}
