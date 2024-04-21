{pkgs, ...}: {
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  environment = {
    plasma6.excludePackages = with pkgs.kdePackages; [
      elisa
      oxygen
      plasma-browser-integration
    ];

    systemPackages = with pkgs; [xwaylandvideobridge];

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
