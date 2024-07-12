{config, ...}: let
  inherit (config.xdg.userDirs) pictures;
in  {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${pictures}/Wallpapers/wall007.png"
      ];
      wallpaper = [
        ",${pictures}/Wallpapers/wall007.png"
      ];
    };
  };
}
