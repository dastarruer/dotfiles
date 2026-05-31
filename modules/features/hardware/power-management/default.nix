{...}: {
  flake.nixosModules.hardware = {...}: {
    # Enable NixOS power management hooks (basic integration).
    powerManagement = {
      enable = true;
      cpuFreqGovernor = "powersave";
    };

    # Enables System76's scheduler tweaks:
    # - Gives foreground/interactive tasks higher CPU priority
    # - Improves desktop responsiveness (especially useful on laptops).
    services.system76-scheduler.settings.cfsProfiles.enable = true;
  };
}
