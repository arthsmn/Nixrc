{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    ./ags.nix
    ./fuzzel.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./hyprshade.nix
    ./mako.nix
    ./settings.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors
    ];
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  xdg.portal = {
    enable = true;
    config.common = {
      default = ["xdph" "gtk"];
      "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
    ];
  };

  programs.hyprcursor-phinger.enable = true;

  home.packages = with pkgs; [
    bluetuith
    brightnessctl
    grimblast
    udiskie
    xwaylandvideobridge
    swww
  ];

  home.pointerCursor = {
    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
    size = 24;
    gtk.enable = true;
  };
}
