{config, ...}: {
  sops = {
    age.keyFile = "/etc/key/keys.txt";
    defaultSopsFile = ../secrets.yaml;
    defaultSopsFormat = "yaml";

    secrets = {
      "user_passwords/arthur" = {neededForUsers = true;};
      "certs/libera".owner = config.users.users.arthur.name;
      "ssh_keys/github_pub".owner = config.users.users.arthur.name;
      "ssh_keys/github".owner = config.users.users.arthur.name;
    };
  };
}
