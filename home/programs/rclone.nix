{...}: {
  services.rclone = {
    enable = true;

    remotes = {
      gdrive = {
        type = "drive";
        scope = "drive";
        # headless flow (you can add tokens here after first auth)
        # token = "...";
        # client_id = "...";
        # client_secret = "...";
      };
    };
  };
}
