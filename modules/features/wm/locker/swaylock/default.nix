{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hypridle = config.custom.wm.idle-daemon == "hypridle";
    locker = config.custom.wm.locker.kind;
    wayland = config.custom.wm.wayland;
  in
    lib.mkIf (locker == "swaylock") {
      assertions = [
        {
          assertion = wayland;
          message = "swaylock only works on Wayland compositors.";
        }
      ];

      home-manager.users.dastarruer = {
        programs.swaylock = {
          enable = true;
          settings = {
            ignore-empty-password = true;

            image = "${config.home-manager.users.dastarruer.home.homeDirectory}/Pictures/wallpaper";
            indicator-x-position = 100;
            indicator-y-position = 950;
          };
        };

        services.hypridle.settings.general.lock_cmd = lib.mkIf hypridle.enable "pidof swaylock || ${pkgs.swaylock}/bin/swaylock";
      };
    };
}
