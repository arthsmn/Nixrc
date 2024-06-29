{
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
  };
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  xdg.configFile."BraveSoftware/Brave-Browser/NativeMessagingHosts/ff2mpv.json".text =
    # json
    ''
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
