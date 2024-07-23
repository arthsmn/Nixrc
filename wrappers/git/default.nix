{
  pkgs,
  nixcfg,
  ...
}: {
  wrappers.git = {
    basePackage = pkgs.git;

    env.GIT_CONFIG_GLOBAL.value = pkgs.substituteAll {
      src = ./config;
      myKey = nixcfg.sops.secrets."ssh_keys/github.pub".path;
    };
  };
}
