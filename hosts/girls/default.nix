{outputs, ...}: {
  imports =
    [
      ./basicSetup.nix
      ./bootloader.nix
      ./desktop.nix
      ./disko.nix
      ./gnome.nix
      ./hardware.nix
      ./hyprland.nix
      ./networking.nix
      ./nix.nix
      ./secrets.nix
      ./users.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);
}
