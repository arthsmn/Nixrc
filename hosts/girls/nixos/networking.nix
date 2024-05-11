{config, ...}: {
  networking = {
    hostName = "girls";

    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
    };

    nftables.enable = true;

    firewall = {
      allowedTCPPorts = [51413];
      allowedUDPPorts = [51413];
    };

    nameservers = [
      "127.0.0.1"
      "::1"
    ];
  };

  services = {
    nextdns = {
      enable = true;
      arguments = [
        "-config-file"
        "${config.sops.secrets.nextdnsID.path}"
      ];
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
