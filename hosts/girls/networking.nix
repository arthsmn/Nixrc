{config, ...}: {
  networking = {
    hostName = "girls";

    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
      wifi.backend = "iwd";
    };

    wireless.iwd = {
      enable = true;
      settings = {
        General = {
          AddressRandomization = "network";
        };
        Network = {
          EnableIPv6 = true;
        };
        Settings = {
          AutoConnect = true;
        };
      };
    };

    firewall = {
      # Torrent
      allowedTCPPorts = [51413];
      allowedUDPPorts = [51413];
    };

    nameservers = [
      # Please don't steal my DNS :)
      "45.90.28.0#NixOS-967e19.dns.nextdns.io"
      "2a07:a8c0::#NixOS-967e19.dns.nextdns.io"
      "45.90.30.0#NixOS-967e19.dns.nextdns.io"
      "2a07:a8c1::#NixOS-967e19.dns.nextdns.io"
    ];
  };

  services = {
    resolved = {
      enable = true;
      dnsovertls = "true";
      fallbackDns = config.networking.nameservers;
      domains = ["~."];
    };

    chrony = {
      enable = true;
      enableNTS = true;
      enableMemoryLocking = true;
      enableRTCTrimming = true;
      servers = ["brazil.time.system76.com"];
    };
  };
}
