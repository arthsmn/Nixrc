{config, lib, pkgs, ...}:
let
  inherit (lib) mkIf mkOption mkEnableOption types;
  cfg = config.desktop;
in {
  imports = [
    ./gnome.nix
    ./hyprland.nix
    ./gdm.nix
  ];

  options.desktop = {
    enable = mkEnableOption "desktop";
    environments = mkOption {
      type = with types; nullOr (listOf (enum ["Gnome" "Hyprland"]));
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
      # TODO: habilitar quando resolverem os problemas das dependências com o python 3.12
      # drivers = with pkgs; [hplip];
    };

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

    hardware.bluetooth.enable = true;

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
  };
}
