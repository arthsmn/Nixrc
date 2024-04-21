{config, ...}: {
  programs.tiny = {
    enable = true;
    settings = {
      servers = [
        {
          addr = "irc.libera.chat";
          port = 6697;
          tls = true;
          alias = "Libera";
          realname = "Arthur";
          nicks = ["arthsmn"];
          sasl = {
            username = "arthsmn";
            pem = config.sops.secrets."certs/libera".path;
          };
          join = [];
        }
      ];
      defaults = {
        tls = true;
        realname = "Arthur";
        nicks = ["arthsmn"];
      };
    };
  };
}
