{inputs, ...}: {
  flake.nixosModules.desktop_steam = {
    config,
    lib,
    ...
  }: let
    myLib = import "${inputs.self}/lib/mkSteamGame.nix" {inherit lib;};
  in {
    programs.steam.config.apps = myLib.mkSteamGame config {
      hitmanwoa = 1659040;
      mgsv = 287700;
      beamng = 284160;
      "ReStory: Chill Electronics Repairs" = 3812600;
    };
  };
}
