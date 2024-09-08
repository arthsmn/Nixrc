{
  lib,
  config,
  pkgs,
  ...
}: {
  boot = {
    loader.efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/efi";
    };

    initrd.systemd.enable = true;

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = ["quiet" "loglevel=3" "systemd.show_status=auto" "rd.udev.log_level=3" "amd_iommu=on" "module.sig_enforce=1" "lockdown=integrity"];

    tmp.cleanOnBoot = true;
  };

  desktop = {
    enable = true;
    environments = [
      "Gnome"
      # "Hyprland"
    ];
  };

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
    sudo-rs.enable = true;
    sudo-rs.execWheelOnly = true;
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
