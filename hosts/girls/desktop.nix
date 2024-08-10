{
  inputs,
  pkgs,
  ...
}: {
  desktop = {
    enable = true;
    environments = ["Gnome"];
  };
}
