{...}: {
  flake.nixosModules.desktop_kdenlive = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      backup = config.services.restic;
      saveDir = "${config.home.homeDirectory}/Videos/kdenlive";
    in {
      home.packages = [
        pkgs.kdePackages.kdenlive
      ];

      # Create the save dir for kdenlive
      systemd.user.tmpfiles.rules = [
        "d ${saveDir} - - - - -"
      ];

      home-manager.services.backup.backupPaths = lib.mkIf backup.enable [saveDir];
    };
  };
}
