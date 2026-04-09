{...}: {
  flake.nixosModules.desktop_krita = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      backup = config.custom.backup;
      saveDir = "${config.home-manager.users.dastarruer.home.homeDirectory}/Pictures/krita";
    in {
      home.packages = [
        pkgs.krita
      ];

      # Create the save dir for krita
      systemd.user.tmpfiles.rules = [
        "d ${saveDir} - - - - -"
      ];

      custom.backup.backupPaths = lib.mkIf backup.enable [saveDir];
    };
  };
}
