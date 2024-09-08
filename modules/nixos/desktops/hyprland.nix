{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf elem mkDefault;
  cfg = config.desktop.environments;
in {
  # imports = [];

  # options = {};

  config = mkIf (elem "Hyprland" cfg) {
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [];

    desktop.loginManager = mkDefault "GDM";
  };
}
