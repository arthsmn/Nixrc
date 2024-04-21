{
  config,
  osConfig,
  ...
}: {
  sops = {
    defaultSopsFile = osConfig.sops.defaultSopsFile;
    defaultSopsFormat = osConfig.sops.defaultSopsFormat;
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets = {
      "ssh_keys/github" = {};
      "ssh_keys/github_pub" = {};
      "certs/libera" = {};
    };
  };

  home.activation.setupEtc = config.lib.dag.entryAfter ["writeBoundary"] "/run/current-system/sw/bin/systemctl start --user sops-nix";
}
