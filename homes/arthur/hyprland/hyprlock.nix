{config, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      # BACKGROUND
      background = {
        monitor = "";
        path = "${config.xdg.userDirs.pictures}/Wallpapers/wall007.png";
        blur_passes = 3;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      # GENERAL
      general = {
        ignore_empty_input = true;
        no_fade_in = true;
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
        placeholder_text = "<i><span foreground=\"##cdd6f4\">Digite a senha...</span></i>";
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

        # # USER
        # {
        #   monitor = "";
        #   text = "Bem vindo de volta, $USER!";
        #   color = "$foreground";
        #   #color = rgba(255, 255, 255, 0.6)
        #   font_size = 25;
        #   font_family = "Sarasa Mono CL";
        #   position = "0, -40";
        #   halign = "center";
        #   valign = "center";
        # }
      ];
    };
  };
}
