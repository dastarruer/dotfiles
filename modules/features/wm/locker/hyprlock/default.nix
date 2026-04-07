{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hypridle = config.home-manager.window-manager.hypridle;
      locker = config.custom.wm.locker;
    in {
      stylix.targets.hyprlock.enable = false;

      # Config taken from here: https://github.com/FireDrop6000/hyprland-mydots/blob/master/.config/hypr/hyprlock.conf
      programs.hyprlock = lib.mkIf (locker == "hyprlock") {
        enable = true;
      };

      services.hypridle.settings.general.lock_cmd = lib.mkIf hypridle.enable "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
    };
  };
}
