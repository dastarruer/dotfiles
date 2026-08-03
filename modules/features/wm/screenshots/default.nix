{...}: {
  flake.nixosModules.wm = {config, ...}: let 
    screenshotPath = config.custom.wm.screenshot.path;
  in {
    home-manager.users.dastarruer = {
      # Create the screenshots dir, deleting files older than 30 days
      systemd.user.tmpfiles.rules = [
        "d ${screenshotPath} - - - 30d -"
      ];
    };
  };
}
