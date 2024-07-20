{pkgs, nixcfg, ...}: {
  wrappers.tiny = {
    basePackage = pkgs.tiny;
    flags = [
      "-c"
      (pkgs.writers.writeYAML "tiny-config" {
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
              pem = nixcfg.sops.secrets."certs/libera".path;
            };
            join = [];
          }
        ];
        defaults = {
          tls = true;
          realname = "Arthur";
          nicks = ["arthsmn"];
        };
      })
    ];
  };
}
