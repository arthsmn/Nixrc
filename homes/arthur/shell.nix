{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (lib) mkIf elem getExe;
in {
  programs.fish = {
    enable = true;
    functions = {
      starship_transient_prompt_func =  "starship module character";
      nsh =
        /*
        fish
        */
        ''
          if ! set -q argv[1]
            echo "O comando precisa de pelo menos um argumento..." && return 1
          end
          for num in (seq (count $argv))
              switch "$argv[$num]"
                  case "-*"
                  case "*"
                      set argv[$num] "nixpkgs#$argv[$num]"
              end
          end
          nix shell $argv
        '';
      last_history_item = "echo $history[1]";
    };
    shellAbbrs = {
      e = {
        position = "anywhere";
        expansion = "${config.home.sessionVariables.EDITOR}";
      };
      l = "ls";
      nxrb = "sudo nixos-rebuild switch";
      "!!" = {
        position = "anywhere";
        function = "last_history_item";
      };
      q = "exit";
      sctl = {
        position = "anywhere";
        expansion = "systemctl";
      };
      sue = "sudoedit";
      te = {
        position = "anywhere";
        expansion = "trash-empty";
      };
      tp = {
        position = "anywhere";
        expansion = "trash-put";
      };
      yt = mkIf config.myPrograms.ytfzf.enable "ytfzf";
      ytm = mkIf config.myPrograms.ytfzf.enable "ytfzf -m";
      em = mkIf config.programs.emacs.enable "emacsclient";
      ga = "git add";
      gb = "git branch";
      gbd = "git branch -D";
      gc = "git commit";
      gcl = "git clone";
      gd = "git diff";
      gf = "git fetch";
      gl = "git log";
      gm = "git merge";
      gp = "git push";
      gpf = "git push -f";
      gpl = "git pull";
      gre = "git restore";
      gr = "git rebase";
      gs = "git switch";
      gsc = "git switch --create";
      gst = "git status";
    };
    interactiveShellInit =
      /*
      fish
      */
      ''
        set -g fish_greeting ""
        nix-your-shell fish | source
        starship init fish | source && enable_transience
        source ${pkgs.fzf}/share/fzf/key-bindings.fish && fzf_key_bindings
      '';
    plugins = [
      {
        name = "autopair.fish";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "1.0.4";
          hash = "sha256-s1o188TlwpUQEN3X5MxUlD/2CFCpEkWu83U9O+wg3VU=";
        };
      }
    ];
  };

  home = {
    shellAliases = {
      cp = "cp -ri";
      adb = "HOME=${config.xdg.dataHome}/android adb";
      df = "df -h";
      dir = "dir --color";
      du = "du -h";
      free = "free -h";
      grep = "grep --color";
      la = "ls -A";
      less = "less -i";
      lla = "ls -lAh";
      ln = "ln -i";
      lr = "ls -R";
      ls = "ls --color";
      mv = "mv -i";
      ping = "ping -c 5";
      rm = "rm -ri";
      vdir = "vdir --color";
      wget = "wget --hsts-file=\"$XDG_CACHE_HOME/wget-hsts\"";
      sbcl = mkIf (elem pkgs.sbcl osConfig.users.users.arthur.packages) "${getExe pkgs.rlwrap} sbcl";
   };

    sessionVariables = {
      MANPAGER = "sh -c 'col -bx | bat --paging always -l man -p'";
      MANROFFOPT = "-c";
      DOTNET_CLI_TELEMETRY_OPTOUT = "1";
      EDITOR = "hx";

      WGETRC = "$XDG_CONFIG_HOME/wgetrc";
      CARGO_HOME = "$XDG_DATA_HOME/cargo";
      DOTNET_CLI_HOME = "$XDG_DATA_HOME/dotnet";
      XCURSOR_PATH = "/usr/share/icons:$XDG_DATA_HOME/icons";
      XCOMPOSECACHE = "$XDG_CACHE_HOME/X11/xcompose";
    };
  };

  xdg.enable = true;
}
