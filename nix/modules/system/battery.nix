{...}: {
  # Most of these settings are from here: https://discourse.nixos.org/t/battery-life-still-isnt-great/41188

  # Enable NixOS power management hooks (basic integration).
  powerManagement.enable = true;

  # Load all available firmware blobs.
  # Ensures WiFi, GPU, sound, etc. have proper drivers and power-saving features.
  hardware.enableAllFirmware = true;

  # Disable GNOME's built-in power-profiles-daemon since we’re using auto-cpufreq instead.
  services.power-profiles-daemon.enable = false;

  services.auto-cpufreq = {
    enable = true;

    settings = {
      # Settings for when running on battery
      battery = {
        governor = "powersave"; # Use the "powersave" CPU governor to reduce frequency scaling.
        turbo = "never"; # Disable CPU turbo boost to save power and lower temps.
      };

      # Settings for when running on AC power (charger plugged in)
      charger = {
        governor = "performance"; # Run CPU in "performance" mode for maximum responsiveness.
        turbo = "auto"; # Allow turbo boost when on AC power.
      };
    };
  };

  ## KERNEL PARAMETERS
  boot.kernelParams = [
    # Enable aggressive SATA link power management (saves power on SSD/HDD).
    "ahci.mobile_lpm_policy=3"

    # Use ACPI alarm for RTC wakeups (more reliable suspend/resume).
    "rtc_cmos.use_acpi_alarm=1"

    # Use AMD’s modern CPU frequency scaling driver (better efficiency on Ryzen).
    "amd_pstate=active"

    # Disable legacy VGA decoding to allow GPU to fully power down.
    "vga_disable_vga=1"
  ];

  systemd.tmpfiles.rules = [
    # Write "balance_power" to all CPU energy performance preference files.
    # This biases the CPU toward energy savings at idle while still scaling up when needed.
    "w /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference - - - - balance_power"
  ];

  # Enables System76's scheduler tweaks:
  # - Gives foreground/interactive tasks higher CPU priority
  # - Improves desktop responsiveness (especially useful on laptops).
  services.system76-scheduler.settings.cfsProfiles.enable = true;
}
