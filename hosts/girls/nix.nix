{
  inputs,
  outputs,
  lib,
  config,
  ...
}: {
  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      allowed-users = ["@wheel"];
      flake-registry = "";
      nix-path = config.nix.nixPath;

      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    channel.enable = false;

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 5";
    flake = "/home/arthur/Nixrc";
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      inputs.rust-overlay.overlays.default
      inputs.nix-your-shell.overlays.default
    ];
  };

  system.stateVersion = "24.05";
}
