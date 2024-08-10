{
  pkgs,
  lib,
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

  environment.systemPackages = [pkgs.sbctl];
}
