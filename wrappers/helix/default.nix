{pkgs, ...}: {
  wrappers.helix = {
    basePackage = pkgs.helix;
    flags = [
      "-c"
      (pkgs.writers.writeTOML "helix-config" {
          theme = "modus_vivendi";
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
          editor.indent-guides.render = true;
          editor.soft-wrap.enable = true;
      })
    ];
  };
}
