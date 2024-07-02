{
  pkgs,
  config,
  ...
}: {
  # TODO:
  # Colors (Stylix)
  # Redshift
  # Light and Dark mode
  # Cycle wallpapers with light and dark variants

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,1";

      "$terminal" = "footclient";
      "$fileManager" = "nautilus";
      "$menu" = "fuzzel";
      "$webBrowser" = "brave";

      exec-once = [
        "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1 &"
        "xwaylandvideobridge &"
        "udiskie --no-automount --no-notify &"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "XCURSOR_THEME,phinger-cursors-dark"
        "HYPRCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,phinger-cursors-dark"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 20;

        border_size = 2;

        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = false;

        allow_tearing = false;

        layout = "master";
      };

      decoration = {
        rounding = 10;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";

        blur = {
          enabled = true;
          size = 4;
          passes = 3;

          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      input = {
        kb_layout = "br";
        kb_options = "caps:escape,shift:both_capslock";

        follow_mouse = 1;

        sensitivity = 0;

        touchpad = {
          natural_scroll = true;
        };
      };

      gestures = {
        workspace_swipe = true;
      };

      "$mainMod" = "Super";

      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, F, exec, $fileManager"
        "$mainMod, W, exec, $webBrowser"
        "$mainMod, E, exec, $menu"
        "$mainMod, B, exec, $terminal bluetuith"
        "$mainMod, V, exec, $terminal invidtui"
        "$mainMod, L, exec, hyprlock"

        "$mainMod, Q, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, V, togglefloating,"

        "$mainMod Shift, Left, layoutmsg, swapwithmaster master"
        "$mainMod Shift, Up, layoutmsg, swapprev"
        "$mainMod Shift, Down, layoutmsg, swapnext"

        "$mainMod, Left, movefocus, l"
        "$mainMod, Right, movefocus, r"
        "$mainMod, Up, movefocus, u"
        "$mainMod, Down, movefocus, d"

        "$mainMod Shift, KP_Left, layoutmsg, swapwithmaster master" # not working
        "$mainMod Shift, KP_Up, layoutmsg, swapprev"
        "$mainMod Shift, KP_Down, layoutmsg, swapnext"

        "$mainMod, KP_Left, movefocus, l"
        "$mainMod, KP_Right, movefocus, r"
        "$mainMod, KP_Up, movefocus, u"
        "$mainMod, KP_Down, movefocus, d"

        "$mainMod, 1, workspace, -1"
        "$mainMod, 2, workspace, +1"

        "$mainMod Shift, 1, movetoworkspace, -1"
        "$mainMod Shift, 2, movetoworkspace, +1"

        "SUPER, p, exec, grimblast save active"
        "SUPER SHIFT, p, exec, grimblast save area"
        # "SUPER ALT, p, exec, grimblast save output"
        "SUPER CTRL, p, exec, grimblast save screen"

        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod Shift, S, movetoworkspace, special:magic"

        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86MonBrightnessUp,exec,brightnessctl set 10%+"
        ",XF86MonBrightnessDown,exec,brightnessctl set 10%-"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*" # You'll probably like this.
        "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"

        # Xwayland Video Bridge
        "opacity 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "maxsize 1 1,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"
      ];

      layerrule = [
        # Mako blur
        "blur, notifications"
        "ignorezero, notifications"
      ];
    };
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

  programs.hyprlock = {
    enable = true;
    settings = {
      # BACKGROUND
      background = {
        monitor = "";
        path = "${config.xdg.userDirs.pictures}/Wallpapers/wall001.png";
        blur_passes = 3;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      # GENERAL
      general = {
        no_fade_in = false;
        grace = 0;
        disable_loading_bar = true;
      };

      # INPUT FIELD
      input-field = {
        monitor = "";
        size = "250, 60";
        outline_thickness = 2;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(0, 0, 0, 0.5)";
        font_color = "rgb(200, 200, 200)";
        fade_on_empty = false;
        font_family = "Sarasa Mono CL";
        placeholder_text = "<i><span foreground=\"##cdd6f4\">Input Password...</span></i>";
        hide_input = false;
        position = "0, -120";
        halign = "center";
        valign = "center";
      };

      # TIME
      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%-I:%M%p\")\"";
          color = "$foreground";
          # color = rgba(255, 255, 255, 0.6)
          font_size = 120;
          font_family = "Sarasa Mono CL";
          position = "0, -300";
          halign = "center";
          valign = "top";
        }

        # USER
        {
          monitor = "";
          text = "Hi there, $USER";
          color = "$foreground";
          #color = rgba(255, 255, 255, 0.6)
          font_size = 25;
          font_family = "Sarasa Mono CL";
          position = "0, -40";
          halign = "center";
          valign = "center";
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

  programs.zathura = {
    enable = true;
    options = {
      font = "Sarasa Mono CL 13";
      database = "sqlite";
      sandbox = "normal";
      statusbar-basename = true;
    };
    mappings = {};
  };

  home.packages = with pkgs; [
    bluetuith
    brightnessctl
    fuzzel
    grimblast
    invidtui
    udiskie
    xwaylandvideobridge
  ];

    home.pointerCursor = {
    name = "phinger-cursors-dark";
    package = pkgs.phinger-cursors;
    size = 24;
    gtk.enable = true;
  };
}
