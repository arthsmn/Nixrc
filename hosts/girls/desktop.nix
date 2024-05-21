{pkgs, ...}: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [pkgs.xterm];
  };

  services.printing.enable = true;

  services.printing.drivers = [pkgs.hplip];

  services.displayManager.autoLogin = {
    enable = true;
    user = "arthur";
  };

  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };

  hardware.pulseaudio.enable = false;

  environment = {
    systemPackages = with pkgs.gnomeExtensions; [blur-my-shell appindicator];

    gnome.excludePackages = with pkgs;
      [
        gnome-connections
        gnome-tour
      ]
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
    # powerOnBoot = false;
  };

  fonts = {
    packages = with pkgs; [
      carlito
      sarasa-gothic
    ];

    fontconfig.defaultFonts.monospace = ["Sarasa Mono CL"];
  };
}
