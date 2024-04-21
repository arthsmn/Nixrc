{
  pkgs,
  config,
  ...
}: {
  programs.mpv = {
    enable = true;

    bindings = {
      "[" = "add speed -0.25";
      "]" = "add speed +0.25";
      "{" = "add speed -0.5";
      "}" = "add speed +0.5";
    };

    config = {
      hwdec = "auto-safe";
      vo = "gpu-next";
      save-position-on-quit = true;
      watch-later-directory = "${config.home.sessionVariables.XDG_STATE_HOME}/mpv";
      volume = 86;
      volume-max = 150;
      window-maximized = true;
      ytdl-format = "bestvideo[height<=?1080]+bestaudio/best";
    };

    scripts = with pkgs.mpvScripts; [sponsorblock-minimal mpris];
    scriptOpts.mpv_sponsorblock_minimal = {
      categories = "sponsor,selfpromo,interaction,intro,outro,preview,music_offtopic";
      hash = "true";
    };
  };
}
