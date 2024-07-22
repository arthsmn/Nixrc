{pkgs, nixcfg, ...}: {
  wrappers.ssh = {
    basePackage = pkgs.openssh;
    flags = [
      "-F"
      (pkgs.substituteAll {
        src = ./config;
        githubKey = nixcfg.sops.secrets."ssh_keys/github".path;
      })
    ];
  };
}
