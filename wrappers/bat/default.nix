{pkgs, ...}: {
  wrappers.bat = {
    basePackage = pkgs.bat;
    env.BAT_THEME.value = "ansi";
  };
}
