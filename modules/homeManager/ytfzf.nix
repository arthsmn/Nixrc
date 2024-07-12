{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.myPrograms.ytfzf;

  settingsFile = let
    renderVariables = attr:
      mapAttrsToList (
        name: value:
          if (isString value)
          then ''${name}="${value}"''
          else "${name}=${toString value}"
      )
      attr;
    renderFunctions = attr:
      mapAttrsToList (name: value: ''${name} () {\n${value}\n}'') attr;
  in
    concatStringsSep "\n"
    ((renderVariables cfg.variables) ++ (renderFunctions cfg.functions) ++ [cfg.extraConfig]);
in {
  options.myPrograms.ytfzf = {
    enable = mkEnableOption "ytfzf terminal youtube client";

    package = mkPackageOption pkgs "ytfzf" {};

    variables = mkOption {
      type = with types; attrsOf (oneOf [ints.unsigned str bool]);
      default = {};
      example = {
        ytdl_pref = "248+bestaudio/best";
        sub_link_count = true;
        show_thumbnails = true;
      };
      description = "The variables for ytfzf.";
    };

    functions = mkOption {
      type = with types; attrsOf nonEmptyStr;
      default = {};
      example = {
        external_menu = /*sh*/ ''
          rofi -dmenu -width 1500 -p "$1"
        '';
        video_player = /*sh*/ ''
          case "$is_detach"
            0) vlc "$@" ;;
            1) setsid -f vlc "$@" > /dev/null 2>&1 ;;
          esac
        '';
        on_opt_parse_c = /*sh*/ ''
          arg="$1"
          case "$arg" in
            SI|S) is_loop=1 ;;
          esac
        '';
      };
      description = "The functions for ytfzf.";
    };

    extraConfig = mkOption {
      type = types.str;
      default = "";
      example = "";
      description = "Extra configuration lines to add to ytfzf config.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    xdg.configFile."ytfzf/conf.sh".text = mkIf (cfg.variables != {} || cfg.functions != {} || cfg.extraConfig != "") settingsFile;
  };
}
