{...}: {
  programs.rclone = {
    enable = true;

    # Declare the rclone config file
    remotes.gdrive.config = {
      type = "drive";
      scope = "drive";
    };
  };
}
