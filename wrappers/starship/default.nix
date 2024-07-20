{pkgs, ...}: {
  wrappers.starship = {
    basePackage = pkgs.starship;
    env.STARSHIP_CONFIG.value = (pkgs.formats.toml {}).generate "starship-config" {
      character = {
        success_symbol = "[λ](bold purple)";
        error_symbol = "[λ](bold red)";
        vicmd_symbol = "[λ](bold green)";
      };
    };
  };
}
