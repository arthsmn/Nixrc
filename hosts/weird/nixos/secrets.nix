{...}: {
  sops = {
    age.keyFile = "/etc/key/keys.txt";
    defaultSopsFile = ../../secrets.yaml;
    defaultSopsFormat = "yaml";

    secrets."user_passwords/bb" = {
      neededForUsers = true;
    };
    secrets."user_passwords/arthur" = {
      neededForUsers = true;
    };
    secrets."nextdnsID" = {};
  };
}
