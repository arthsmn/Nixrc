{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./gnome.nix
    ./hyprland.nix
  ];
  
  services.printing = {
    enable = true;
    # TODO: habilitar quando resolverem os problemas das dependências com o python 3.12
    # drivers = with pkgs; [hplip];
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
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
  };

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-gtk
  #     inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
  #   ];
  # };

  fonts = {
    packages = with pkgs; [
      carlito
      sarasa-gothic
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
      noto-fonts
      inter
    ];

    fontconfig = {
      defaultFonts = {
        monospace = ["Sarasa Mono CL"];
        serif = ["Noto Serif"];
        sansSerif = ["Inter"];
      };
      subpixel.rgba = "rgb";
    };
  };
}
