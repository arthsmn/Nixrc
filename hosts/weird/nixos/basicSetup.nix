{
  lib,
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = with pkgs; [
    brave
    libreoffice-qt
    kcalc
  ];

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

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [intel-media-driver intel-vaapi-driver];
  };

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
    fstrim.enable = true;
    earlyoom.enable = true;
    fwupd.enable = true;
  };

  programs = {
    fish.enable = true;
    nix-index-database.comma.enable = true;
    command-not-found.enable = false;
  };

  zramSwap.enable = true;

  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = false;
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";

      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };
}
