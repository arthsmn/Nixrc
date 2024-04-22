{...}: let
  btrfsMountOptions = [ "autodefrag" "compress=zstd:1" "noatime" ];
in {
  disko.devices = {
    disk = {
      nvme0n1 = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/efi";
                mountOptions = [ "defaults" "noexec" "nosuid" "nodev" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                passwordFile = "/tmp/secret.key";
                settings.allowDiscards = true;
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" "--csum xxhash" ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = btrfsMountOptions;
                    };
                    "/persistent" = {
                      mountpoint = "/persistent";
                      mountOptions = btrfsMountOptions;
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = btrfsMountOptions;
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
