{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: let
    night-light = config.custom.wm.night-light;
    wayland = config.custom.wm.wayland;
  in
    lib.mkIf (night-light == "hyprsunset") {
      assertions = [
        {
          assertion = wayland;
          message = "hyprsunset only works on Wayland compositors.";
        }
      ];

      home-manager.users.dastarruer = {
        services.hyprsunset = {
          enable = true;

          extraArgs = [
            # Change temperature to a slightly warmer 5500K
            "-t"
            "5500"
          ];
        };
      };
    };
}
