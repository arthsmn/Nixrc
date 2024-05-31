{
  lib,
  pkgs,
  ...
}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "adwaita-dark";
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
      language = [
        # {
        #   name = "nix";
        #   auto-format = true;
        #   formatter = {
        #     command = lib.getExe pkgs.alejandra;
        #     args = [];
        #   };
        # }
        {
          name = "haskell";
          auto-format = true;
          formatter = {
            command = lib.getExe pkgs.fish;
            args = ["-c" "${lib.getExe pkgs.haskellPackages.fourmolu} --stdin-input-file $(pwd)"];
          };
        }
      ];
    };
  };
}
