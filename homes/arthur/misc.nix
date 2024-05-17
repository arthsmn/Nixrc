{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: {
  programs = {
    yazi = {
      enable = true;
      enableFishIntegration = true;
      settings.manager = {
        sort_by = "natural";
        sort_reverse = false;
      };
    };

    ssh = {
      enable = true;
      addKeysToAgent = "yes";
      matchBlocks = {
        "github.com" = {
          identityFile = config.sops.secrets."ssh_keys/github".path;
        };
      };
    };

    git = {
      enable = true;
      userEmail = "arthsmn@proton.me";
      userName = "arthsmn";
      signing = {
        key = config.sops.secrets."ssh_keys/github_pub".path;
        signByDefault = true;
      };
      extraConfig = {
        gpg.format = "ssh";
        init.defaultBranch = "master";
      };
    };

    yt-dlp = {
      enable = true;
      extraConfig = "-o %(title)s.%(ext)s";
    };

    fzf.enable = true;

    bat = {
      enable = true;
      config.theme = "ansi";
    };

    bottom = {
      enable = true;
      settings.flags = {
        basic = true;
        battery = true;
        enable_cache_memory = true;
        mem_as_value = true;
        disable_advanced_kill = true;
      };
    };

    ghostty = {
      enable = true;
      package = inputs.ghostty.packages.x86_64-linux.default;
      settings = {
        font-family = "Sarasa Mono CL";
        font-size = 15;
        cursor-style = "bar";
        window-height = 30;
        window-width = 140;
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
  };

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  services.ssh-agent.enable = true;

  xdg.configFile."BraveSoftware/Brave-Browser/NativeMessagingHosts/ff2mpv.json".text = ''
    {
    	"name": "ff2mpv",
    	"description": "ff2mpv's extenal manifest",
    	"path": "${lib.getExe pkgs.ff2mpv-rust}",
    	"type": "stdio",
    	"allowed_origins": [
    		"chrome-extension://ephjcajbkgplkjmelpglennepbpmdpjg/"
    	]
    }
  '';
}
