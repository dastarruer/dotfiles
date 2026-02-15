{
  config,
  lib,
  pkgs,
  ...
}: let
  hypridle = config.home-manager.window-manager.hypridle;
in {
  imports = [
    ./pfp.nix
    ./password-input.nix
    ./date.nix
    ./battery-status.nix
    ./background.nix
  ];

  config = lib.mkIf (config.home-manager.window-manager.screen-locker == "hyprlock") {
    # Config taken from here: https://github.com/FireDrop6000/hyprland-mydots/blob/master/.config/hypr/hyprlock.conf
    programs.hyprlock = {
      enable = true;
    };

    services.hypridle.settings.general.lock_cmd = lib.mkIf hypridle.enable "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock && sleep 0.1";
  };
}
