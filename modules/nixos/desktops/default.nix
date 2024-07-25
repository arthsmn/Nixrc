{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkOption mkEnableOption types;
  cfg = config.desktop;
in {
  imports = [
    ./gnome.nix
    ./gdm.nix
  ];

  options.desktop = {
    enable = mkEnableOption "desktop";
    environments = mkOption {
      type = with types; nullOr (listOf (enum ["Gnome"]));
    };
    loginManager = mkOption {
      type = types.enum ["GDM"];
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      excludePackages = with pkgs; [xterm];
    };

    services.printing = {
      enable = true;
      drivers = [pkgs.hplip];
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_USE_XINPUT2 = "1";
    };

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    hardware.bluetooth.enable = true;

    fonts = {
      packages = with pkgs; [
        (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
        carlito
        inter
        noto-fonts
        iosevka-comfy.comfy
        iosevka-comfy.comfy-duo
        iosevka-comfy.comfy-motion
        iosevka-comfy.comfy-motion-duo
        iosevka-comfy.comfy-motion-fixed
        iosevka-comfy.comfy-fixed
      ];

      fontconfig = {
        defaultFonts = {
          monospace = ["Iosevka Comfy"];
          serif = ["Noto Serif"];
          sansSerif = ["Inter"];
        };
        subpixel.rgba = "rgb";
      };
    };
  };
}
