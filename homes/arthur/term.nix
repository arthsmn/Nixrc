{
  pkgs,
  inputs,
  ...
}: {
  programs = {
    ghostty = {
      enable = true;
      package = inputs.ghostty.packages.x86_64-linux.default;
      settings = {
        font-family = "Sarasa Term CL";
        font-size = 15;
        cursor-style = "bar";
        # window-height = 30;
        # window-width = 140;
        gtk-single-instance = true;
      };
      extraConfig = ''
        palette = 0=#241f31
        palette = 1=#c01c28
        palette = 2=#2ec27e
        palette = 3=#f5c211
        palette = 4=#1e78e4
        palette = 5=#9841bb
        palette = 6=#0ab9dc
        palette = 7=#c0bfbc
        palette = 8=#5e5c64
        palette = 9=#ed333b
        palette = 10=#57e389
        palette = 11=#f8e45c
        palette = 12=#51a1ff
        palette = 13=#c061cb
        palette = 14=#4fd2fd
        palette = 15=#f6f5f4
        background = #1e1e1e
        foreground = #ffffff
      '';
    };

    foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          font = "Sarasa Term CL:size=15, Symbols Nerd Font Mono:size=13";
          pad = "20x12 center";
          include = "${pkgs.foot.themes}/share/foot/themes/modus-vivendi";
        };
        cursor.style = "beam";
        mouse.hide-when-typing = true;
        csd.preferred = "none";
      };
    };

    kitty = {
      enable = true;
      font = {
        name = "Sarasa Term CL";
        size = 15;
      };
      settings = {
        update_check_interval = 0;
        cursor_shape = "beam";
        enable_audio_bell = false;
        wayland_enable_ime = false;
        hide_window_decorations = true;
      };
      theme = "Modus Vivendi";
    };
  };
}
