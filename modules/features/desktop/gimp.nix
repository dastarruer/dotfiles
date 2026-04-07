{...}: {
  flake.nixosModules.desktop_gimp = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      backup = config.services.restic;
      saveDir = "${config.home.homeDirectory}/Pictures/gimp";
    in {
      home.packages = [
        pkgs.gimp
      ];

      # Create the save dir for gimp
      systemd.user.tmpfiles.rules = [
        "d ${saveDir} - - - - -"
      ];

      home-manager.services.backup.backupPaths = lib.mkIf backup.enable [saveDir];
    };
  };
}
