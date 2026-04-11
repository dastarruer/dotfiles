{...}: {
  flake.nixosModules.desktop_krita = {
    config,
    pkgs,
    lib,
    ...
  }: let
    backup = config.custom.backup;
    saveDir = "${config.home-manager.users.dastarruer.home.homeDirectory}/Pictures/krita";
  in {
    custom.backup.backupPaths = lib.mkIf backup.enable [saveDir];

    home-manager.users.dastarruer = {
      home.packages = [
        pkgs.krita
      ];

      # Create the save dir for krita
      systemd.user.tmpfiles.rules = [
        "d ${saveDir} - - - - -"
      ];
    };
  };
}
