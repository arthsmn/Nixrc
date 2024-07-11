{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  # TODO:
  # Colors
  # Light and Dark mode
  # Cycle wallpapers with light and dark variants

  imports = [
    ./settings.nix
    ./hyprlock.nix
    ./hypridle.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors
    ];
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd.enableXdgAutostart = true;
  };

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-gtk
  #     inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
  #   ];
  # };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${config.xdg.userDirs.pictures}/Wallpapers/wall007.png"
      ];
      wallpaper = [
        ",${config.xdg.userDirs.pictures}/Wallpapers/wall007.png"
      ];
    };
  };

  programs.hyprcursor-phinger.enable = true;

  services.mako = {
    enable = true;
    font = "Sarasa Mono CL 13";
    borderRadius = 5;
    defaultTimeout = 6000;
    backgroundColor = "#000000";
    borderColor = "#1e1e1e";
    textColor = "#ffffff";
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      key-bindings = {
        cursor-right = "Right Control+f KP_Right";
        cursor-right-word = "Control+Right Mod1+f Control+KP_Right";
        cursor-left = "Left Control+b KP_Left";
        cursor-left-word = "Control+Left Mod1+b Control+KP_Left";
        prev = "Up Control+p KP_Up";
        next = "Down Control+n KP_Down";
      };
      colors = {
        background = "000000f0";
        text = "fffffff0";
        match = "4ae2f0f0";
        selection = "313131ff";
        selection-text = "ffffffff";
        selection-match = "00eff0ff";
        border = "1e1e1ef0";
      };
    };
  };

  home.packages = with pkgs; [
    bluetuith
    brightnessctl
    grimblast
    udiskie
    xwaylandvideobridge
    swww
  ];

  programs.ags = {
    enable = true;
    # configDir = ./ags;
    extraPackages = with pkgs; [];
  };

  home.pointerCursor = {
    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
    size = 24;
    gtk.enable = true;
  };

  services.ssh-agent.enable = true;

  myPrograms.hyprshade = {
    enable = true;
    config = /*toml*/ ''
                [[shades]]
                name = "custom-blue-light-filter-1"
                start_time = 18:00:00
                end_time = 20:00:00

                [[shades]]
                name = "custom-blue-light-filter-2"
                start_time = 20:00:01
                end_time = 06:00:00
    '';
    customShaders = {
      custom-blue-light-filter-1 = lib.replaceStrings ["2600"] ["3500"] (lib.readFile "${pkgs.hyprshade}/share/hyprshade/shaders/blue-light-filter.glsl");
      custom-blue-light-filter-2 = lib.replaceStrings ["2600"] ["3100"] (lib.readFile "${pkgs.hyprshade}/share/hyprshade/shaders/blue-light-filter.glsl");
    };
  };
}
