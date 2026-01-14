{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.home-manager.cli.rclone;
in {
  systemd.user = lib.mkIf cfg.enable {
    services.backup = {
      Unit = {
        Description = "User Backup Service";
        After = ["network.target"];
        WantedBy = ["multi-user.target"];
      };

      Service = {
        Type = "oneshot";
        ExecStart = let
          name = "backup";
        in "${pkgs.writeShellApplication {
          name = name;

          runtimeInputs = [
            pkgs.rclone
          ];

          text = ''
            REMOTE="gdrive:"

            # Explicitly point to your user's rclone config
            RCLONE_CONF="${config.home.homeDirectory}/.config/rclone/rclone.conf"
            export RCLONE_CONFIG="$RCLONE_CONF"

            # Pull paths from the Nix config into a Bash array
            SOURCE_PATHS=( ${lib.escapeShellArgs config.home-manager.cli.rclone.backupPaths} )

            echo "Checking rclone status for $REMOTE..."
            if ! rclone --config "$RCLONE_CONF" about "$REMOTE" >/dev/null 2>&1; then
                echo "Remote not found or needs authentication. Attempting reconnect..."
                rclone --config "$RCLONE_CONF" config reconnect "$REMOTE"
            fi

            # Backup each source path
            for SRC in "''${SOURCE_PATHS[@]}"; do
              if [ -e "$SRC" ]; then
                if [ -d "$SRC" ]; then
                  echo "Syncing directory $SRC to GDrive..."
                  rclone --config "$RCLONE_CONF" sync "$SRC" "$REMOTE/Backups/$(basename "$SRC")" -PL
                else
                  echo "Copying file $SRC to GDrive..."
                  rclone --config "$RCLONE_CONF" copy "$SRC" "$REMOTE/Backups/" -PL
                fi
              else
                echo "Warning: $SRC does not exist, skipping."
              fi
            done
          '';
        }}/bin/${name}";
      };
    };

    timers.backup = {
      Unit.Description = "Run user backup service daily.";

      Timer = {
        OnCalendar = "daily";
        Persistent = true;
        RandomizedDelaySec = "1h";
      };

      Install.WantedBy = ["timers.target"];
    };
  };
}
