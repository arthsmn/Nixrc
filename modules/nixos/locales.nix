{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf types;

  cfg = config.locales;
in {
  options.locales = {
    locale = mkOption {
      type = types.nonEmptyStr;
      default = "en_US";
      example = "pt_BR";
    };

    spellchecker = mkEnableOption "Enable spellchecker support and install the appropriate locale";
  };

  config = let
    utf8Locale = "${cfg.locale}.UTF-8";
  in
    mkIf (cfg.locale != "") {
      i18n.defaultLocale = utf8Locale;
      i18n.extraLocaleSettings = {
        LC_ADDRESS = utf8Locale;
        LC_IDENTIFICATION = utf8Locale;
        LC_MEASUREMENT = utf8Locale;
        LC_MONETARY = utf8Locale;
        LC_NAME = utf8Locale;
        LC_NUMERIC = utf8Locale;
        LC_PAPER = utf8Locale;
        LC_TELEPHONE = utf8Locale;
        LC_TIME = utf8Locale;
      };

      environment.systemPackages = mkIf cfg.spellchecker (with pkgs; [
        hunspell
        hunspellDicts.${cfg.locale}
      ]);
    };
}
