{
  config,
  osConfig,
  ...
}: {
  sops = {
    defaultSopsFile = osConfig.sops.defaultSopsFile;
    defaultSopsFormat = osConfig.sops.defaultSopsFormat;
    age.keyFile = "/home/arthur/.config/sops/age/keys.txt";

    secrets."ssh_keys/github" = {
      path = "${config.home.homeDirectory}/.ssh/github";
    };

    secrets."ssh_keys/github_pub" = {
      path = "${config.home.homeDirectory}/.ssh/github.pub";
    };

    secrets."certs/libera" = {
      path = "${config.home.homeDirectory}/.config/tiny/certs/libera.pem";
    };
  };

  home.activation.setupEtc = config.lib.dag.entryAfter ["writeBoundary"] "/run/current-system/sw/bin/systemctl start --user sops-nix";
}
