{inputs, ...}: {
  flake.nixosModules.desktop_steam = {
    config,
    lib,
    ...
  }: let
    myLib = import "${inputs.self}/lib/mkSteamGame.nix" {inherit lib;};
  in {
    programs.steam.config.apps = myLib.mkSteamGame config {
      "1659040" = "HITMAN World of Assassination";
      "287700" = "METAL GEAR SOLID V: THE PHANTOM PAIN";
      "284160" = "beam.ng";
      "3812600" = "ReStory: Chill Electronics Repairs";
    };
  };
}
