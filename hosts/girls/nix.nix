{
  inputs,
  outputs,
  ...
}: {
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      allowed-users = ["@wheel"];
    };
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
