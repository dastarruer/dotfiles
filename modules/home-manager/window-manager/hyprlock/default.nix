{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./pfp.nix
    ./password-input.nix
    ./date.nix
    ./battery-status.nix
    ./background.nix
  ];

  options = {
    home-manager.window-manager.hyprlock.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.home-manager.window-manager.enable;
      description = "Enable hyprlock.";
    };
  };

  config = lib.mkIf config.home-manager.window-manager.hyprlock.enable {
    # Config taken from here: https://github.com/FireDrop6000/hyprland-mydots/blob/master/.config/hypr/hyprlock.conf
    programs.hyprlock = {
      enable = true;
    };

    # Set the lock command for hypridle, which will handle locking screen before suspend
    services.hypridle.settings.general.lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock && sleep 0.1";
  };
}
