{...}: {
  flake.nixosModules.desktop_musescore = {
    config,
    pkgs,
    lib,
    ...
  }: let
    backup = config.custom.backup;
    saveDir = "${config.home-manager.users.dastarruer.home.homeDirectory}/Documents/MuseScore4/Scores";
  in {
    custom.backup.backupPaths = lib.mkIf backup.enable [saveDir];
    home-manager.users.dastarruer = {
      home.packages = with pkgs; [
        musescore
        muse-sounds-manager
      ];
    };
  };
}
