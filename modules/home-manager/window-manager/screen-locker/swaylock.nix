{
  config,
  lib,
  pkgs,
  ...
}: let
  hypridle = config.home-manager.window-manager.hypridle;
in {
  config = lib.mkIf (config.home-manager.window-manager.screen-locker == "swaylock") {
    programs.swaylock = {
      enable = true;
    };

    services.hypridle.settings.general.lock_cmd = lib.mkIf hypridle.enable "pidof swaylock || ${pkgs.swaylock}/bin/swaylock && sleep 0.1";
  };
}
