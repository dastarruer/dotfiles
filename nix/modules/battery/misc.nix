{...}: {
  # Just some miscellaneous battery settings

  # Enable NixOS power management hooks (basic integration).
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  # Load all available firmware blobs.
  # Ensures WiFi, GPU, sound, etc. have proper drivers and power-saving features.
  hardware.enableAllFirmware = true;

  systemd.tmpfiles.rules = [
    # Write "balance_power" to all CPU energy performance preference files.
    # This biases the CPU toward energy savings at idle while still scaling up when needed.
    "w /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference - - - - balance_power"
  ];

  # Enables System76's scheduler tweaks:
  # - Gives foreground/interactive tasks higher CPU priority
  # - Improves desktop responsiveness (especially useful on laptops).
  services.system76-scheduler.settings.cfsProfiles.enable = true;

  powerManagement.powertop.enable = true;
}
