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

    # settings = mkOption {
      #   type = types.attrs;
      #   default = {};
      #   description = "Settings for hyprshade";
      # };

    config = mkOption {
      type = types.nonEmptyStr;
      default = "";
      description = "Configuration in toml format";
      };

      customShaders = mkOption {
        type = with types; lazyAttrsOf nonEmptyStr;
        default = {};
        description = "Custom shaders for hyprshade";
      };

      enableHyprlandIntegration = mkOption {
        type = types.bool;
        default = true;
        description = "Write hyprshade integration to Hyprland's config";
      };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    xdg.configFile = mkMerge [
      (mapAttrs' (name: value: nameValuePair "hypr/shaders/${name}.glsl" {
        text = value;
      }) cfg.customShaders)
      (mkIf (cfg.config != {}) { "hypr/hyprshade.toml" =  {
                                   # source = pkgs.writers.writeTOML "config.toml" cfg.settings;
                                   text = cfg.config;
                                 };
                                    })
    ];

    home.activation.hm_hyprshade_install = mkIf (cfg.config != {} || cfg.customShaders != {}) (hm.dag.entryAfter ["writeBoundary"] ''
      ${getExe pkgs.hyprshade} install
      ${pkgs.systemd}/bin/systemctl --user enable --now hyprshade.timer
    '');

    wayland.windowManager.hyprland.extraConfig = mkIf cfg.enableHyprlandIntegration (mkOrder 200 ''
      exec-once = dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE
      exec = hyprshade auto
    '');
  };  
}
