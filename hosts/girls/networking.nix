{config, ...}: {
  networking = {
    hostName = "girls";

    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
    };

    # Breaks virtual networks
    # nftables.enable = true;

    firewall = {
      allowedTCPPorts = [51413];
      allowedUDPPorts = [51413];
    };

    nameservers = [
      # Please don't steal my DNS :)
      "45.90.28.0#967e19.dns.nextdns.io"
      "2a07:a8c0::#967e19.dns.nextdns.io"
      "45.90.30.0#967e19.dns.nextdns.io"
      "2a07:a8c1::#967e19.dns.nextdns.io"
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
