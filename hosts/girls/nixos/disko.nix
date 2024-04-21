{...}: let
  btrfsMountOptions = [ "autodefrag" "compress=zstd:1" "noatime" "commit=120" ];
in {
  disko.devices = {
    disk = {
      nvmeXXX = {
        type = "disk";
        device = "/dev/nvmeXXX";
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
