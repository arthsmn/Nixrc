{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    monitor = ",preferred,auto,1";

    "$terminal" = "footclient";
    "$fileManager" = "nautilus";
    "$menu" = "fuzzel";
    "$webBrowser" = "brave";

    exec-once = [
      "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1 &"
      "xwaylandvideobridge &"
      "udiskie --no-automount --no-notify &"
      "dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE" # para o hyprshade
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
      "float,class:^(xdg-desktop-portal-gtk)$"
      "float,class:^(brave-nngceckbapebfimnlniiiahkandclblb-Default)$"

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

    # "plugin:dynamic-cursors" = {
    #   enabled = true;
    #   mode = "rotate";
    #   thredshold = 2;
    # };
  };
}
