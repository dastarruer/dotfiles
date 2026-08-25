{ lib, ... }:

{
  mkSteamGame = config: apps:
    lib.mapAttrs (_id: name: {
      inherit name;

      # Unset to fix gamescope stutter issues: https://github.com/ValveSoftware/gamescope/issues/163#issuecomment-2143491396
      env.LD_PRELOAD = null;
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