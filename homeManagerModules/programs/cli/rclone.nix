{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.cli.rclone.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable rclone, a program for accessing cloud drives from the terminal.";
    };
  };

  config = lib.mkIf config.dotfiles.cli.rclone.enable {
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
