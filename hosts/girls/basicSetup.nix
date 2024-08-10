{
  lib,
  config,
  ...
}: {
  time.timeZone = "America/Sao_Paulo";

  console.useXkbConfig = true;
  services.xserver.xkb = {
    layout = "br";
    variant = "";
    options = "caps:escape,shift:both_capslock";
  };

  # Custom module
  locales = {
    locale = "pt_BR";
    spellChecker = true;
    extraLangs = ["en_US"];
  };

  hardware.graphics.enable = true;

  security = {
    sudo.execWheelOnly = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
    };
  };

  services = {
    dbus.apparmor = lib.mkIf config.security.apparmor.enable "enabled";
    fwupd.enable = true;
    btrfs.autoScrub.enable = true;
  };

  programs = {
    fish.enable = true;
    nix-index-database.comma.enable = true;
    command-not-found.enable = false;
    virt-manager.enable = true;
  };

  virtualisation.libvirtd.enable = true;

  zramSwap.enable = true;
}
