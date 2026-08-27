{...}: {
  flake.nixosModules.hardware = {
    config,
    lib,
    ...
  }: let
    daemon = config.custom.hardware.power-management;
  in
    lib.mkIf (daemon == "tuned") {
      services.tuned = {
        enable = true;
      };
    };
}
