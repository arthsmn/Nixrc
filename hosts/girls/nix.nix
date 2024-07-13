
{
  inputs,
  outputs,
  ...
}: {
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
    allowed-users = ["@wheel"];

    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 5 --keep-since 3d";
    flake = "/home/arthur/Nixrc";
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = (with outputs.overlays; [additions modifications])
               ++ (with inputs; [
                 emacs-overlay.overlays.default
                 rust-overlay.overlays.default
                 nix-your-shell.overlays.default
    ]);
  };

  system.stateVersion = "24.11";
}
