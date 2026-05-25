{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: let
    night-light = config.custom.wm.night-light;
  in {
    home-manager.users.dastarruer = lib.mkIf (night-light == "hyprsunset") {
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
