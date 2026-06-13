{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: let
    wayland = config.custom.wm.wayland;
    bar = config.custom.wm.bar.bar;
    night-light = config.custom.wm.night-light;
  in
    lib.mkIf (night-light == "noctalia") {
      assertions = [
        {
          assertion = wayland;
          message = "noctalia is only compatible with Wayland compositors.";
        }
        {
          assertion = bar == "noctalia";
          message = "noctalia night light daemon only works after enabling the noctalia bar.";
        }
      ];

      home-manager.users.dastarruer = {
        programs.noctalia.settings.nightlight = {
          enabled = true;
          force = true; # Use night temperature and disregard day temp
          temperature_night = 5500;
        };
      };
    };
}
