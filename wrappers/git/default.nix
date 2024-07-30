{
  pkgs,
  nixcfg,
  ...
}: let
  writeGitINI = attr: builtins.toFile "git-config" (pkgs.lib.generators.toGitINI attr);
in {
  wrappers.git = {
    basePackage = pkgs.git;

    env.GIT_CONFIG_GLOBAL.value = writeGitINI {
      user = {
        email = "arthsmn@proton.me";
        name = "arthsmn";
        signingKey = nixcfg.sops.secrets."ssh_keys/github.pub".path;
      };
      commit.gpgSign = true;
      gpg.format = "ssh";
      init.defaultBranch = "master";
      push.autoSetupRemote = true;
      tag.gpgSign = true;
    };
  };
}
