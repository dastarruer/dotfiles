{...}: {
  flake.nixosModules.desktop_krita = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      backup = config.services.restic;
      saveDir = "${config.home.homeDirectory}/Pictures/krita";
    in {
      home.packages = [
        pkgs.krita
      ];

      # Create the save dir for krita
      systemd.user.tmpfiles.rules = [
        "d ${saveDir} - - - - -"
      ];

      home-manager.services.backup.backupPaths = lib.mkIf backup.enable [saveDir];
    };
  };
}
