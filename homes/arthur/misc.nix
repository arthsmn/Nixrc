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
        push.autoSetupRemote = true;
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

  home.pointerCursor = {
    name = "Adwaita";
    size = 24;
    package = pkgs.adwaita-icon-theme;
    gtk.enable = true;
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

  home.file.".mozilla/native-messaging-hosts/ff2mpv.json".text = /*json*/ ''
    {
      "name": "ff2mpv",
      "description": "ff2mpv's external manifest",
      "path": "/nix/store/mrids67xr67dr762z11cxhmlk0kfsbaq-ff2mpv-rust-1.1.5/bin/ff2mpv-rust",
      "type": "stdio",
      "allowed_extensions": [
        "ff2mpv@yossarian.net"
      ]
    }
  '';

  home.file = {
    ".mozilla/firefox/gqccus5g.default/chrome/firefox-gnome-theme".source = pkgs.fetchzip {
      url = "https://github.com/rafaelmardojai/firefox-gnome-theme/archive/refs/tags/v127.tar.gz";
      hash = "sha256-ihOVmsno400zgdgSdRRxKRzmKiydH0Vux7LtSDpCyUI=";
    };
    ".mozilla/firefox/gqccus5g.default/chrome/userChrome.css".text = /*css*/ ''
      @import "firefox-gnome-theme/userChrome.css";
    '';
    ".mozilla/firefox/gqccus5g.default/chrome/userContent.css".text = /*css*/ ''
      @import "firefox-gnome-theme/userContent.css";
    '';
  };
}
