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

      boot.kernelParams = ["amd_pstate=active" "amdgpu.abmlevel=3" "pcie_aspm.policy=powersupersave"];
      services.udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="pci", ATTR{power/control}="auto"
      '';
      networking.networkmanager.wifi.powersave = true;

      services.auto-cpufreq = {
        enable = true;

        settings = {
          # Settings for when running on battery
          battery = {
            governor = "powersave";
            turbo = "never"; # so fans aren't so goddamn loud
            energy_performance_preference = "power";
          };

          # Settings for when plugged in
          charger = {
            governor = "performance";
            energy_performance_preference = "performance";
            turbo = "auto";
          };
        };
      };
    };
}
