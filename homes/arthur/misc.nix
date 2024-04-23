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
        palette = 0=#262626
        palette = 1=#ee5396
        palette = 2=#42be65
        palette = 3=#ffe97b
        palette = 4=#33b1ff
        palette = 5=#ff7eb6
        palette = 6=#3ddbd9
        palette = 7=#dde1e6
        palette = 8=#393939
        palette = 9=#ee5396
        palette = 10=#42be65
        palette = 11=#ffe97b
        palette = 12=#33b1ff
        palette = 13=#ff7eb6
        palette = 14=#3ddbd9
        palette = 15=#ffffff
        background = #161616
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
