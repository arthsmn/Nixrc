{pkgs, ...}: {
  desktop = {
    enable = true;
    environments = ["Gnome"];
    loginManager = "GDM";
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    install = true;
  };
}
