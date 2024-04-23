{pkgs, ...}: {
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.enable = true;
  services.xserver.excludePackages = [pkgs.xterm];
  hardware.pulseaudio.enable = false;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "arthur";
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  environment = {
    systemPackages = with pkgs.gnomeExtensions; [
      hide-top-bar
      blur-my-shell
    ];

    gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-connections
    ] ++ (with pkgs.gnome; [
      geary
      gnome-calendar
      gnome-contacts
      gnome-weather
      gnome-clocks
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
      carlito
    ];

    fontconfig.defaultFonts.monospace = ["Sarasa Mono CL"];
  };
}
