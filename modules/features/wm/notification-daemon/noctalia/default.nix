{inputs, ...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: let
    wayland = config.custom.wm.wayland;
    bar = config.custom.wm.bar.bar;
    notifications = config.custom.wm.notifications.daemon;
  in
    lib.mkIf (notifications == "noctalia") {
      assertions = [
        {
          assertion = wayland;
          message = "noctalia is only compatible with Wayland compositors.";
        }
        {
          assertion = bar == "noctalia";
          message = "noctalia notification daemon only works after enabling the noctalia bar.";
        }
      ];

      home-manager.users.dastarruer = {
        programs.noctalia.settings = {
          notification = {
            enable_daemon = true;
            background_opacity = 1.0;
            scale = 0.95;
            layer = "overlay"; # show notifications in full screen window

            # Not sure how to block based on description though
            blacklist = config.custom.wm.notifications.excludeTitles;
          };

          audio = {
            enable_sounds = true;
            notification_sound = "${inputs.self.outPath}/config/audio/notification.wav";
          };
        };
      };
    };
}
