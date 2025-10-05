{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    ludusavi
  ];

  # Without this, home manager can't symlink files to .config (https://github.com/nix-community/home-manager/issues/1807#issuecomment-3131623755)
  xdg.configFile = {
    "ludusavi/config.yaml".enable = false;
  };

  # Symlink ludusavi config.yaml file
  home.file.".config/ludusavi/config.yaml".source =
    config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/.dotfiles/config/ludusavi/config/yaml";

  # Automate backups: https://github.com/mtkennerly/ludusavi/blob/master/docs/help/backup-automation.md
  systemd.user.services.ludusavi = {
    Unit = {
      Description = "Ludusavi backup";
    };

    Service = {
      ExecStart = "${pkgs.writeShellScript "ludusavi-backup" ''
        #!/run/current-system/sw/bin/bash
        ${pkgs.libnotify}/bin/notify-send "It's that time of day!" "Starting ludusavi backup..."
        ${pkgs.ludusavi}/bin/ludusavi backup --force || ${pkgs.libnotify}/bin/notify-send "Ludusavi backup failed" "Check system status for more information."
      ''}";
    };
  };

  # Timer to trigger automatic backups daily
  systemd.user.timers.ludusavi = {
    Unit = {
      Description = "Ludusavi backup timer";
    };

    Timer = {
      OnCalendar = "16:00";
    };

    Install = {
      WantedBy = ["timers.target"];
    };
  };
}
