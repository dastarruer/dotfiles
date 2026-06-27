{...}: {
  flake.nixosModules.hardware = {
    config,
    lib,
    ...
  }: let
    daemon = config.custom.hardware.power-management;
  in
    lib.mkIf (daemon == "auto-cpufreq") {
      # cpufreq handles cpu and powertop handles other stuff
      powerManagement.powertop.enable = true;

      services.auto-cpufreq = {
        enable = true;

        settings = {
          # Settings for when running on battery
          battery = {
            governor = "powersave";
            turbo = "never"; # so fans aren't so goddamn loud

            # Specifically works for laptops w the 'ideapad_laptop' kernel module
            # `lsmod | grep ideapad_laptop`
            ideapad_laptop_conservation_mode = true;
          };

          # Settings for when plugged in
          charger = {
            governor = "performance";
            turbo = "auto";
          };
        };
      };
    };
}
