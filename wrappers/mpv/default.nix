{pkgs, ...}: {
  wrappers.mpv = {
    basePackage = pkgs.mpv.override { scripts = with pkgs.mpvScripts; [
      sponsorblock-minimal
      mpris
      uosc
      thumbfast
    ];};
    flags = [ "--config-dir=${./config}" ];
  };
  }
