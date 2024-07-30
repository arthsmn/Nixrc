{
  inputs,
  pkgs,
  ...
}: {
  desktop = {
    enable = true;
    environments = ["Gnome"];
  };
  services.xserver.videoDrivers = ["amdgpu"];
}
