{config, lib, pkgs, ...}:
let
  inherit (lib) mkIf;
  cfg = config.desktop.loginManager;
in {
  # imports = [];

  # options = {};

  config = mkIf (cfg == "GDM") {
    services.xserver.displayManager.gdm.enable = true;
  };
}
