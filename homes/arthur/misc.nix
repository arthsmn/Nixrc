{
  lib,
  pkgs,
  config,
  ...
}: {
  programs = {
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
  };
    
  gtk = {
    enable = true;
    theme.name = "adw-gtk3-dark";
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
}
