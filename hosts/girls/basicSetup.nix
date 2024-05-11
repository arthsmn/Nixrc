{
  lib,
  pkgs,
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

  hardware.opengl.enable = true;

  security = {
    sudo.execWheelOnly = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
    };
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      ovmf.packages = with pkgs; [OVMFFull.fd];
    };
  };

  programs.virt-manager.enable = true;

  services = {
    dbus.apparmor = lib.mkIf config.security.apparmor.enable "enabled";
    earlyoom.enable = true;
    fwupd.enable = true;
    btrfs.autoScrub.enable = true;
  };

  programs = {
    fish.enable = true;
    nix-index-database.comma.enable = true;
    command-not-found.enable = false;
  };

  zramSwap.enable = true;
}
