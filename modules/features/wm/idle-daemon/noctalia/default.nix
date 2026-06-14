{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;
    wayland = config.custom.wm.wayland;
    bar = config.custom.wm.bar.bar;
    idle-daemon = config.custom.wm.idle-daemon;
    locker = config.custom.wm.locker.kind;
  in
    lib.mkIf (idle-daemon == "noctalia") {
      assertions = [
        {
          assertion = wayland;
          message = "noctalia is only compatible with Wayland compositors.";
        }
        {
          assertion = bar == "noctalia";
          message = "noctalia idle daemon only works after enabling the noctalia bar.";
        }
      ];

      home-manager.users.dastarruer = {
        programs.noctalia.settings.idle = {
          # Wait before running an idle command
          pre_action_fade_seconds = 2.0;

          behavior = {
            lock = {
              enabled = true;
              command =
                if (locker == "noctalia")
                then "noctalia:session lock" # i doth believe i need to use this syntax
                else config.custom.wm.locker.command;
              timeout = 300;
            };

            custom = {
              enabled = true;
              command = "${lib.getExe hmConfig.programs.noctalia.package} msg session lock-and-suspend";
              timeout = 600;
            };
          };
        };
      };
    };
}
