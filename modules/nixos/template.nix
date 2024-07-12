{config, lib, pkgs, ...}:
let
  inherit (lib) mkIf mkOption types;
  cfg = config.something;
in {
  imports = [];

  options = {};

  config = mkIf cfg.enable {};
}
