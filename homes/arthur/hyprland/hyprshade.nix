{lib, pkgs, ...}:let
  inherit (lib) replaceStrings readFile;
in {
  myPrograms.hyprshade = {
    enable = true;
    config = /*toml*/ ''
                [[shades]]
                name = "custom-blue-light-filter-1"
                start_time = 18:00:00
                end_time = 20:00:00

                [[shades]]
                name = "custom-blue-light-filter-2"
                start_time = 20:00:01
                end_time = 00:00:00

                [[shades]]
                name = "custom-blue-light-filter-3"
                start_time = 00:00:01
                end_time = 06:00:00
    '';
    customShaders = {
      custom-blue-light-filter-1 = replaceStrings ["2600"] ["3500"] (readFile "${pkgs.hyprshade}/share/hyprshade/shaders/blue-light-filter.glsl");
      custom-blue-light-filter-2 = replaceStrings ["2600"] ["3100"] (readFile "${pkgs.hyprshade}/share/hyprshade/shaders/blue-light-filter.glsl");
      custom-blue-light-filter-3 = replaceStrings ["2600"] ["2800"] (readFile "${pkgs.hyprshade}/share/hyprshade/shaders/blue-light-filter.glsl");
    };
  };
}
