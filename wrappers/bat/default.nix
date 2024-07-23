{pkgs, ...}: {
  wrappers.bat = {
    basePackage = pkgs.bat;
    flags = ["--theme" "ansi"];
  };
}
