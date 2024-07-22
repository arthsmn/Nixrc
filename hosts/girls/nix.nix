{
  inputs,
  outputs,
  ...
}: {
  nix = {
    # channel.enable = false;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      allowed-users = ["@wheel"];
      use-xdg-base-directories = true;
    };
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 5 --keep-since 3d";
    flake = "/home/arthur/Nixrc";
  };

  nixpkgs = {
    overlays =
      (with outputs.overlays; [additions modifications])
      ++ (with inputs; [
        nix-your-shell.overlays.default
        emacs-overlay.overlays.emacs
      ]);
  };

  system.stateVersion = "24.11";
}
