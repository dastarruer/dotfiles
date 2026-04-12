{...}: {
  flake.nixosModules.desktop_gimp = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      backup = config.custom.backup;
      saveDir = "${config.home-manager.users.dastarruer.home.homeDirectory}/Pictures/gimp";
    in {
      home.packages = [
        pkgs.gimp
      ];

      # Create the save dir for gimp
      systemd.user.tmpfiles.rules = [
        "d ${saveDir} - - - - -"
      ];

      custom.backup.backupPaths = lib.mkIf backup.enable [saveDir];
    };
  };
}
