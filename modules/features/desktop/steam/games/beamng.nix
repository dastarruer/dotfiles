# beam.ng
{...}: {
  flake.nixosModules.desktop_steam = {
    config,
    lib,
    ...
  }: {
    programs.steam.config = {
      apps.beamng = {
        id = 284160;
        wrappers = [
          (lib.getExe config.programs.gamescope.package)
          # set window to monitor resolution
          "-W"
          "1920"
          "-H"
          "1080"
          # render game at 720p
          "-w"
          "1600"
          "-h"
          "900"
          # upscale to monitor resolution
          "-F"
          "fsr"
          "-f"
          "--"
          (lib.getExe config.programs.gamemode.package)
        ];
      };
    };
  };
}
