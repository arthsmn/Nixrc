{pkgs, ...}: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = with pkgs; [xterm];
  };

  services.printing.enable = true;

  services.printing.drivers = with pkgs; [hplip];

  hardware.pulseaudio.enable = false;

  environment = {
    systemPackages = with pkgs.gnomeExtensions; [
      appindicator
      legacy-gtk3-theme-scheme-auto-switcher
    ];

    gnome.excludePackages =
      (with pkgs; [
        gnome-connections
        gnome-tour
      ])
      ++ (with pkgs.gnome; [
        geary
        gnome-calendar
        gnome-contacts
        gnome-maps
        gnome-music
        gnome-weather
        simple-scan
        totem
      ]);

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_USE_XINPUT2 = "1";
    };
  };

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    # alsa.enable = true;
    # alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
  };

  fonts = {
    packages = with pkgs; [
      carlito
      sarasa-gothic
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ];

    fontconfig.defaultFonts.monospace = ["Sarasa Mono CL"];
  };
}
