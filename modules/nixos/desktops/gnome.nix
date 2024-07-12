{config, lib, pkgs, ...}:
let
  inherit (lib) mkIf elem;
  cfg = config.desktop.environments;
in {
  # imports = [];

  # options = {};

  config = mkIf (elem "Gnome" cfg) {
    services.xserver.desktopManager.gnome.enable = true;

    environment = {
      systemPackages = with pkgs.gnomeExtensions; [
        appindicator
        legacy-gtk3-theme-scheme-auto-switcher
      ];

      gnome.excludePackages =
        (with pkgs; [
          geary
          gnome-calendar
          gnome-connections
          gnome-tour
          simple-scan
          totem
        ])
        ++ (with pkgs.gnome; [
          gnome-contacts
          gnome-maps
          gnome-music
          gnome-weather
        ]);
    };

    hardware.pulseaudio.enable = false;
  };
}
