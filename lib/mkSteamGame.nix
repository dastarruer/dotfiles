{ lib, ... }:

{
  mkSteamGame = config: apps:
    lib.mapAttrs (_name: id: {
      inherit id;

      wrappers = [
        (lib.getExe config.programs.gamescope.package)
        "-W" "1920"
        "-H" "1080"
        "-w" "1600"
        "-h" "900"
        "-F" "fsr"
        "-f"
        "--"
        (lib.getExe config.programs.gamemode.package)
      ];
    }) apps;
}