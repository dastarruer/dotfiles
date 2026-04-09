{...}: {
  flake.nixosModules.desktop_kdenlive = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      backup = config.custom.backup;
      saveDir = "${config.home-manager.users.dastarruer.home.homeDirectory}/Videos/kdenlive";
    in {
      home.packages = [
        pkgs.kdePackages.kdenlive
      ];

      # Create the save dir for kdenlive
      systemd.user.tmpfiles.rules = [
        "d ${saveDir} - - - - -"
      ];

      custom.backup.backupPaths = lib.mkIf backup.enable [saveDir];
    };
  };
}
