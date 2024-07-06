{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.myPrograms.hyprshade;
in
  with lib; {
    options.myPrograms.hyprshade = {
      enable = mkEnableOption "hyprland shader client";

      package = mkPackageOption pkgs "hyprshade" {};

      settings = mkOption {
        type = types.attrs;
        default = {};
        description = "Settings for hyprshade";
      };

      customShaders = mkOption {
        type = with types; lazyAttrsOf nonEmptyStr;
        default = {};
      };
    };

    config = mkIf cfg.enable {
      home.packages = [cfg.package];

      xdg.configFile =
        (mkIf (cfg.customShaders != {}) (mapAttrs' (name: def: {
            name = "hypr/shaders/${name}.glsl";
            value = def;
          })
          cfg.customShaders))
        + {"hypr/hyprshade.toml".text = mkIf (cfg.settings != {}) pkgs.writers.writeTOML cfg.settings;};

      # Instalar automaticamente
    };
  }
