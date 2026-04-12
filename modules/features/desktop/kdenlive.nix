{...}: {
  flake.nixosModules.desktop_kdenlive = {
    config,
    pkgs,
    lib,
    ...
  }: let
    backup = config.custom.backup;
    saveDir = "${config.home-manager.users.dastarruer.home.homeDirectory}/Videos/kdenlive";
  in {
    custom.backup.backupPaths = lib.mkIf backup.enable [saveDir];

    home-manager.users.dastarruer = {
      home.packages = [
        pkgs.kdePackages.kdenlive
      ];

      # Create the save dir for kdenlive
      systemd.user.tmpfiles.rules = [
        "d ${saveDir} - - - - -"
      ];
    };
  };
}
