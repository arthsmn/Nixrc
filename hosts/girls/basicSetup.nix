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

  locales = {
    locale = "pt_BR";
    spellchecker = true;
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
    steam.enable = true;
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu.swtpm.enable = true;
  };

  zramSwap.enable = true;
}
