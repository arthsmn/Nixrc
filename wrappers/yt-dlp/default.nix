{pkgs, ...}: {
  wrappers.yt-dlp = {
    basePackage = pkgs.yt-dlp;
    flags = [ "-o %(title)s.%(ext)s" ];
  };
}
