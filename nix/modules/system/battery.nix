{...}: {
  # Most of these settings are from here: https://discourse.nixos.org/t/battery-life-still-isnt-great/41188
  ## POWER
  powerManagement = {
    enable = true;
  };

  hardware.enableAllFirmware = true;

  # Disable gnome power management
  services.power-profiles-daemon.enable = false;

  services.auto-cpufreq = {
    enable = true;

    settings = {
      # Use powersave governor on battery
      battery = {
        governor = "powersave";
        turbo = "never";
      };

      # Use performance governor on charger
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  ### KERNEL
  boot.kernelParams = [
    "ahci.mobile_lpm_policy=3"
    "rtc_cmos.use_acpi_alarm=1"
    "amd_pstate=active"
    "vga_disable_vga=1"
  ];

  ### HWP
  systemd.tmpfiles.rules = [
    "w /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference - - - - balance_power"
  ];

  ### SYSTEM 76 SCHEDULER
  services.system76-scheduler.settings.cfsProfiles.enable = true;
}
