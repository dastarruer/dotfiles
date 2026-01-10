{
  config,
  lib,
  ...
}: {
  options = {
    home-manager.cli.rclone = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.home-manager.cli.enable;
        description = "Enable rclone, a program for accessing cloud drives from the terminal.";
      };
      backupPaths = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "List of local directories to back up via rclone.";
        example = ["/home/user/Documents" "/home/user/Pictures"];
      };
    };
  };

  config = lib.mkIf config.home-manager.cli.rclone.enable {
    programs.rclone = {
      enable = true;

      # Declare the rclone config file
      remotes.gdrive.config = {
        type = "drive";
        scope = "drive";
      };
    };
  };
}
