{outputs, ...}: {
  imports =
    [
      ./basicSetup.nix
      ./bootloader.nix
      ./desktop.nix
      ./hardware.nix
      ./networking.nix
      ./nix.nix
      ./printing.nix
      ./secrets.nix
      ./users.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);
}
