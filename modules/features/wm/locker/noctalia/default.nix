{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: let
    wayland = config.custom.wm.wayland;
    bar = config.custom.wm.bar.bar;
    locker = config.custom.wm.locker;
  in
    lib.mkIf (locker == "noctalia") {
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
        programs.noctalia.settings = {
          lockscreen.enabled = true;
          lockscreen_widgets = {
            enabled = true;

            # can't be bothered, who cares abt their lockscreen i see it maybe twice a day-
            # clock = {
            #   type = "clock";
            #   output = "DP-1";
            #   cx = 405.0;
            #   cy = 0.0;
            #   box_width = 360.0;
            #   box_height = 120.0;
            #   format = "%k:%M";
            # };

            lockscreen-login-box = {
              background_opacity = 1.0;
              background_radius = 0.0;
              input_opacity = 1.0;
              input_radius = 0.0;
            };
          };
        };
      };
    };
}
