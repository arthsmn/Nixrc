{
  lib,
  config,
  inputs,
  outputs,
  pkgs,
  ...
}: {
  nix = {
    # TODO: remover quando o nix atualizar pra uma versão >= 2.19
    package = pkgs.nixVersions.nix_2_19;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      use-xdg-base-directories = true;
      allowed-users = ["@wheel"];
    };

    registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    nixPath = ["/etc/nix/path"];

    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    # };
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 5";
    flake = "/home/arthur/Nixrc";
  };

  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      inputs.rust-overlay.overlays.default
      inputs.nix-your-shell.overlays.default
    ];
  };

  system.stateVersion = "23.11";
}
