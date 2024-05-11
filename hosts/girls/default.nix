{outputs, ...}: {
  imports =
    [
      ./basicSetup.nix
      ./bootloader.nix
      ./desktop.nix
      ./disko.nix
      ./hardware.nix
      ./networking.nix
      ./nix.nix
      ./secrets.nix
      ./users.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);
}
