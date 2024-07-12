{...}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        password-character = "•";
        terminal = "$TERMINAL";
        width = 45;
        horizontal-pad = 20;
        vertical-pad = 10;
        inner-pad = 5;
      };
      key-bindings = {
        cursor-right = "Right Control+f KP_Right";
        cursor-right-word = "Control+Right Mod1+f Control+KP_Right";
        cursor-left = "Left Control+b KP_Left";
        cursor-left-word = "Control+Left Mod1+b Control+KP_Left";
        prev = "Up Control+p KP_Up";
        next = "Down Control+n KP_Down";
      };
      colors = {
        background = "000000f0";
        text = "fffffff0";
        match = "4ae2f0f0";
        selection = "313131ff";
        selection-text = "ffffffff";
        selection-match = "00eff0ff";
        border = "1e1e1ef0";
      };
    };
  };
}
