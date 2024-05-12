{
  pkgs,
  lib,
  ...
}: {
  boot = {
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/efi";
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams =
      ["quiet" "loglevel=3" "systemd.show_status=auto" "rd.udev.log_level=3" "amd_iommu=on"]
      ++ [ "module.sig_enforce=1" "lockdown=integrity" ] # https://github.com/nix-community/lanzaboote/issues/88
      ;

    tmp.cleanOnBoot = true;
  };

  environment.systemPackages = [pkgs.sbctl];
}
