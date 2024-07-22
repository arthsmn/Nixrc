{pkgs, nixcfg, ...}: {
  wrappers.git = {
    basePackage = pkgs.git;

    env.GIT_CONFIG_GLOBAL.value = pkgs.substituteAll {
      src = ./config;
      gpgPath = pkgs.lib.getExe pkgs.gnupg;
      myKey = nixcfg.sops.secrets."ssh_keys/github_pub".path;
    };
  };
}
