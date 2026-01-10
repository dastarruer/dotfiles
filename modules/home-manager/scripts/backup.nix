{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.programs.rclone.enable {
    # 1. Define the Overlay
    nixpkgs.overlays = [
      (final: prev: {
        backup = prev.writeShellApplication {
          name = "backup";

          runtimeInputs = with prev; [
            rclone
            rsync
            util-linux
            coreutils
            # Cannot run notify-send when runnning a script as sudo
            # libnotify
          ];

          text = ''
            USB_DEVICE="/dev/sda1"
            MOUNT_POINT="/media/dastarruer/mnt"
            REMOTE="gdrive:"

            # Explicitly point to your user's rclone config
            RCLONE_CONF="${config.home.homeDirectory}/.config/rclone/rclone.conf"
            export RCLONE_CONFIG="$RCLONE_CONF"

            # Pull paths from the Nix config into a Bash array
            SOURCE_PATHS=( ${lib.escapeShellArgs config.home-manager.cli.rclone.backupPaths} )

            # Dynamic globs check
            for f in "$HOME"/Downloads/SponsorBlockConfig*.json "$HOME"/Downloads/tab-groups-backup*; do
              [ -e "$f" ] && SOURCE_PATHS+=("$f")
            done

            echo "Mounting USB drive..."
            # Ensure the mount point exists
            mkdir -p "$MOUNT_POINT"

            if mount "$USB_DEVICE" "$MOUNT_POINT"; then
                echo "Drive mounted successfully at $MOUNT_POINT."
            else
                echo "Drive mount failed. Check the connection or if it's already mounted."
                exit 1
            fi

            echo "Checking rclone status for $REMOTE..."
            if ! rclone --config "$RCLONE_CONF" about "$REMOTE" >/dev/null 2>&1; then
                echo "Remote not found or needs authentication. Attempting reconnect..."
                rclone --config "$RCLONE_CONF" config reconnect "$REMOTE"
            fi

            for SRC in "''${SOURCE_PATHS[@]}"; do
              if [ -e "$SRC" ]; then
                # Google Drive logic
                if [ -d "$SRC" ]; then
                  echo "Syncing directory $SRC to GDrive..."
                  rclone --config "$RCLONE_CONF" sync "$SRC" "$REMOTE/Backups/$(basename "$SRC")" -PL
                else
                  echo "Copying file $SRC to GDrive..."
                  rclone --config "$RCLONE_CONF" copy "$SRC" "$REMOTE/Backups/" -PL
                fi

                # USB logic
                echo "Syncing $SRC to USB..."
                rsync -avh --progress --delete "$SRC" "$MOUNT_POINT"
              else
                echo "Warning: $SRC does not exist, skipping."
              fi
            done

            echo "--------------------------------------"
            echo "Backup complete. Press enter to eject the USB drive:"
            read -r

            echo "Unmounting and Ejecting USB drive..."
            umount "$MOUNT_POINT"
            if eject "$USB_DEVICE"; then
                echo "Drive ejected safely."
            else
                echo "Failed to eject the drive. If you have a tab open currently in the mount directory, close it. Eject manually with: 'sudo eject $USB_DEVICE'"
                exit 1
            fi
          '';
        };
      })
    ];

    # 2. Add the package from the overlay to home.packages
    home.packages = [
      pkgs.backup
    ];
  };
}
