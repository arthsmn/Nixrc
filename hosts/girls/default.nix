{outputs, ...}: {
  imports =
    [
      ./basicSetup.nix
      ./bootloader.nix
      ./desktop
      ./disko.nix
      ./hardware.nix
      ./networking.nix
      ./nix.nix
      ./secrets.nix
      ./users.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);
}
