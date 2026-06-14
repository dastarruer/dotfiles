{...}: {
  flake.nixosModules.hardware_power-management = {config, ...}: let
    daemon = config.custom.hardware.power-management;
  in {
    services.power-profiles-daemon.enable = daemon == "power-profiles-daemon";
  };
}
