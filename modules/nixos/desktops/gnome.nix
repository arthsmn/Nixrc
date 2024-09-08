{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkDefault elem;
  cfg = config.desktop.environments;
in {
  # imports = [];

  # options = {};

  config = mkIf (elem "Gnome" cfg) {
    services.xserver.desktopManager.gnome.enable = true;

    environment = {
      systemPackages = with pkgs;
        [
          adw-gtk3
          (blackbox-terminal.override {sixelSupport = true;})
          dconf-editor
          foliate
          fragments
        ]
        ++ (with gnomeExtensions; [
          alphabetical-app-grid
          blur-my-shell
          caffeine
          gnome-bedtime
          hot-edge
          just-perfection
          legacy-gtk3-theme-scheme-auto-switcher
          night-theme-switcher
          pop-shell
        ]);

      gnome.excludePackages = with pkgs; [
        geary
        gnome-calendar
        gnome-connections
        gnome-console
        gnome-contacts
        gnome-font-viewer
        gnome-maps
        gnome-music
        gnome-tour
        gnome-weather
        simple-scan
        totem
        yelp
      ];
    };

    hardware.pulseaudio.enable = false;

    services.system76-scheduler.enable = true;

    desktop.loginManager = mkDefault "GDM";
  };
}
