# https://github.com/nix-community/disko/blob/master/example/btrfs-subvolumes.nix
{...}: {
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        # Change this to your target disk
        # Find the target disk by running `lsblk`
        device = "/dev/disk/by-id/nvme-SKHynix_HFS512GEJ4X112N_5YCBN01211090BA34";
        content = {
          type = "gpt";
          partitions = {
            # 1. EFI System Partition (ESP)
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "512M"; # 512M is the "sweet spot" to avoid boot partition full errors
              type = "EF00"; # Standard code for EFI partitions
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                # 'umask=0077' ensures only the root user can read boot files (security best practice)
                mountOptions = ["umask=0077"];
              };
            };
            # 2. Main Btrfs Partition
            root = {
              size = "100%"; # Use all remaining space on the disk
              content = {
                type = "btrfs";
                # '-f' (force) is used by nixos-anywhere to overwrite any existing partition table
                extraArgs = ["-f"];

                # Btrfs uses 'subvolumes' instead of traditional partitions.
                # They share the same pool of free space, so you don't need to size them individually.
                subvolumes = {
                  # The actual OS root
                  "/root" = {
                    mountpoint = "/";
                    # 'compress=zstd' saves space and can improve speed.
                    # 'noatime' prevents the drive from writing 'last accessed' timestamps (saves SSD wear).
                    mountOptions = ["compress=zstd" "noatime"];
                  };

                  # Your personal data. Keeping this separate makes it easier to
                  # reinstall the OS without losing your files.
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = ["compress=zstd"];
                  };

                  # The Nix Store. This can get very large, so we separate it.
                  # It is marked 'noatime' because Nix files are read constantly.
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd" "noatime"];
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
