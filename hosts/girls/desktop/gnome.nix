{pkgs, ...}: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = with pkgs; [xterm];
  };

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
}
