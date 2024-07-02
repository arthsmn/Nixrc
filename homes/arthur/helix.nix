{
  lib,
  pkgs,
  ...
}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "modus_vivendi_transparent";
      editor = {
        line-number = "relative";
        cursorline = true;
        true-color = true;
        color-modes = true;
        bufferline = "multiple";
      };
      editor.cursor-shape = {
        insert = "underline";
        normal = "bar";
      };
      editor.statusline = {
        left = ["mode" "spinner" "read-only-indicator" "file-modification-indicator"];
        center = ["file-name"];
      };
      editor.whitespace.render.space = "all";
      editor.indent-guides.render = true;
      editor.soft-wrap.enable = true;
    };
    languages = {
      language-server = {
        nixd.command = lib.getExe pkgs.nixd;
        hyprls.command = lib.getExe pkgs.hyprls;
      };
      language = [
        {
          name = "nix";
          # auto-format = true;
          formatter.command = lib.getExe pkgs.alejandra;
          language-servers = ["nixd"];
        }
        {
          name = "haskell";
          auto-format = true;
          formatter = {
            command = lib.getExe pkgs.ormolu;
            args = [];
          };
        }
        {
          name = "hyprlang";
          language-servers = ["hyprls"];
        }
      ];
    };
    themes = {
      modus_vivendi_transparent = {
        inherits = "modus_vivendi";
        "ui.background" = {};
        "ui.statusline" = {};
        "ui.statusline.inactive" = {};
        "ui.bufferline.background" = {};
      };
    };
  };
}
