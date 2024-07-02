{pkgs, ...}: {
  services.printing = {
    enable = true;
    drivers = with pkgs; [hplip];
  };

  hardware.pulseaudio.enable = false;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_USE_XINPUT2 = "1";
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
