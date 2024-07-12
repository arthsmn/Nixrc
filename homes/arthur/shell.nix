{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:let
  inherit (lib) mkIf elem getExe;
in {
  programs.fish = {
    enable = true;
    functions = {
      send-terminfo-ssh = /*fish*/ ''
          if ! set -q $argv; or test -z $argv[2];
            echo "Apenas um argumento é necessário, o host..."
            return 1
          end
          infocmp -x | ssh $argv[1] -- tic -x -
        '';
      yta = mkIf config.programs.mpv.enable "mpv --no-resume-playback --ytdl-format=bestaudio ytdl://ytsearch:\"$argv\"";
      starship_transient_prompt_func = mkIf config.programs.starship.enable "starship module character";
      vterm_printf = /*fish*/ ''
          if begin; [  -n "$TMUX" ]  ; and  string match -q -r "screen|tmux" "$TERM"; end
             # tell tmux to pass the escape sequences through
             printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
          else if string match -q -- "screen*" "$TERM"
             # GNU screen (screen, screen-256color, screen-256color-bce)
             printf "\eP\e]%s\007\e\\" "$argv"
          else
           printf "\e]%s\e\\" "$argv"
          end
        '';
      nsh = /*fish*/ ''
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
    };
    shellAbbrs = {
      e = {
        position = "anywhere";
        expansion = "${config.home.sessionVariables.EDITOR}";
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
    interactiveShellInit = /*fish*/  ''
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
      sbcl = mkIf (elem pkgs.sbcl osConfig.users.users.arthur.packages) "rlwrap sbcl";
      emacs = mkIf config.programs.emacs.enable "emacs -nw";
      emacsclient = mkIf config.services.emacs.enable "emacsclient -nw";
    };

    sessionVariables = {
      MANPAGER = "sh -c 'col -bx | ${getExe pkgs.bat} --paging always -l man -p'";
      MANROFFOPT = "-c";
      RUST_SRC_PATH = "${pkgs.rust-bin.stable.latest.default}/lib/rustlib/src/rust/library";
      DOTNET_CLI_TELEMETRY_OPTOUT = "1";
    };
  };

  xdg.enable = true;

  programs.starship = {
    enable = true;
    enableTransience = config.programs.fish.enable;
    settings = {
      character = {
        success_symbol = "[λ](bold purple)";
        error_symbol = "[λ](bold red)";
        vicmd_symbol = "[λ](bold green)";
      };
    };
  };
}
