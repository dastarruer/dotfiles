{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.rclone.enable = lib.mkEnableOption "Enable git functionality.";
  };

  config = lib.mkIf config.myPrograms.rclone.enable {
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
