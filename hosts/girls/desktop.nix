{inputs, pkgs, ...}: {
  desktop = {
    enable = true;
    environments = ["Gnome"];
    loginManager = "GDM";
  };
}
