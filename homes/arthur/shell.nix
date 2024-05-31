{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  vars = config.home.sessionVariables;
  homedir = config.home.homeDirectory;
in
  with lib; {
    programs.fish = {
      enable = true;
      functions = {
        send-terminfo-ssh = ''
          if ! set -q $argv; or test -z $argv[2];
            echo "Apenas um argumento é necessário, o host..."
            return 1
          end
          infocmp -x | ssh $argv[1] -- tic -x -
        '';
        yta = mkIf config.programs.mpv.enable "mpv --ytdl-format=bestaudio ytdl://ytsearch:\"$argv\"";
        starship_transient_prompt_func = mkIf config.programs.starship.enable "starship module character";
        nsh = ''
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
        nrn = ''
          if ! set -q argv[1]
            echo "O comando precisa de pelo menos um argumento..." && return 1
          end
          nix run nixpkgs#$argv[1] $argv[2..]
        '';
      };
      shellAbbrs = {
        cdpkgs = "cd nixpkgs";
        e = {
          position = "anywhere";
          expansion = "${vars.EDITOR}";
        };
        flin = mkIf osConfig.services.flatpak.enable "flatpak install";
        flist = mkIf osConfig.services.flatpak.enable "flatpak list";
        flrm = mkIf osConfig.services.flatpak.enable "flatpak remove --delete-data";
        flrmu = mkIf osConfig.services.flatpak.enable "flatpak remove --unused --delete-data";
        flrun = mkIf osConfig.services.flatpak.enable "flatpak run";
        flup = mkIf osConfig.services.flatpak.enable "flatpak update";
        l = "ls";
        nxrb = "sudo nixos-rebuild switch";
        py = "python";
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
      interactiveShellInit = ''
        set -g fish_greeting ""
        nix-your-shell fish | source
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
        adb = "HOME=${vars.XDG_DATA_HOME}/android adb";
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
        sbcl = "rlwrap sbcl";
      };

      sessionVariables = {
        CDPATH = ".:~/Repositórios/:~/Mídia";
        MANPAGER = "sh -c 'col -bx | ${lib.getExe pkgs.bat} --paging always -l man -p'";
        MANROFFOPT = "-c";
        RUST_SRC_PATH = "${pkgs.rust-bin.stable.latest.default}/lib/rustlib/src/rust/library";

        XDG_CACHE_HOME = "${homedir}/.cache";
        XDG_CONFIG_HOME = "${homedir}/.config";
        XDG_DATA_HOME = "${homedir}/.local/share";
        XDG_STATE_HOME = "${homedir}/.local/state";
      };
    };

    xdgVars = {
      enable = true;
      variables = {
        cache = vars.XDG_CACHE_HOME;
        config = vars.XDG_CONFIG_HOME;
        data = vars.XDG_DATA_HOME;
        state = vars.XDG_STATE_HOME;
        runtime = "$XDG_RUNTIME_DIR";
      };
    };

    programs.starship = {
      enable = true;
      enableTransience = config.programs.fish.enable;
      settings = {
        character = {
          success_symbol = "[λ](bold green)";
          error_symbol = "[λ](bold red)";
          vicmd_symbol = "[λ](bold purple)";
        };
      };
    };
  }
