{config, ...}: {
  networking = {
    hostName = "weird";

    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
    };

    nameservers = [
      "127.0.0.1"
      "::1"
    ];

    firewall = {
      # KTorrent
      allowedUDPPorts = [6881 7881 8881];
      allowedTCPPorts = [6881];
    };
  };

  services.nextdns = {
    enable = true;
    arguments = [
      "-config-file"
      "${config.sops.secrets.nextdnsID.path}"
    ];
  };

  services.chrony = {
    enable = true;
    enableNTS = true;
    enableMemoryLocking = true;
    enableRTCTrimming = true;
    servers = ["brazil.time.system76.com"];
  };
}
