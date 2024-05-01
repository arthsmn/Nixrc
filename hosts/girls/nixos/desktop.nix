{pkgs, ...}: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = [pkgs.xterm];
  };

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
    systemPackages = with pkgs.gnomeExtensions; [
      hide-top-bar
      blur-my-shell
    ];

    gnome.excludePackages = with pkgs;
      [
        gnome-tour
        gnome-connections
      ]
      ++ (with pkgs.gnome; [
        geary
        gnome-calendar
        gnome-contacts
        gnome-weather
        gnome-maps
        totem
        simple-scan
        gnome-music
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
    powerOnBoot = false;
  };

  fonts = {
    packages = with pkgs; [
      sarasa-gothic
      (iosevka.override {
        set = "ng";
        privateBuildPlan = {
          family = "Iosevkang";

          variants.inherits = "ss07";
          design = ["curly-flat-boundary"];

          ligations.inherits = "dlig";
        };
      })
      carlito
    ];

    fontconfig.defaultFonts.monospace = ["Sarasa Mono CL"];
  };
}
