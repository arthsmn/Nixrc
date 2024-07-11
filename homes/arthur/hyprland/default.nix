{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  # TODO:
  # Colors (Stylix)
  # Hyprshade
  # Light and Dark mode
  # Cycle wallpapers with light and dark variants

  imports = [
    ./settings.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      # inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors
    ];
    systemd.enableXdgAutostart = true;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${config.xdg.userDirs.pictures}/Wallpapers/wall001.png"
      ];

      wallpaper = [
        ",${config.xdg.userDirs.pictures}/Wallpapers/wall001.png"
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  programs.hyprcursor-phinger.enable = true;

  services.mako = {
    enable = true;
    font = "Sarasa Mono CL 12";
    borderRadius = 5;
    defaultTimeout = 6000;
  };

  programs.sioyek.enable = true;

  home.packages = with pkgs; [
    bluetuith
    brightnessctl
    fuzzel
    grimblast
    udiskie
    xwaylandvideobridge
    hyprshade
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
