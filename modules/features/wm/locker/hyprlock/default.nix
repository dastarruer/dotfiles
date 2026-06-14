{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    wayland = config.custom.wm.wayland;
    hypridle = config.custom.wm.idle-daemon == "hypridle";
    locker = config.custom.wm.locker.kind;
  in {
    assertions = [
      {
        assertion = wayland;
        message = "hyprlock only works on Wayland compositors.";
      }
    ];

    home-manager.users.dastarruer = {
      stylix.targets.hyprlock.enable = false;

      # Config taken from here: https://github.com/FireDrop6000/hyprland-mydots/blob/master/.config/hypr/hyprlock.conf
      programs.hyprlock = lib.mkIf (locker == "hyprlock") {
        enable = true;
      };

      services.hypridle.settings.general.lock_cmd = lib.mkIf hypridle.enable "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
    };
  };
}
