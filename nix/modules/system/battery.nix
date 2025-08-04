{...}: {
  # Most of these settings are from here: https://discourse.nixos.org/t/battery-life-still-isnt-great/41188
  ## POWER
  powerManagement = {
    enable = true;
    #cpuFreqGovernor = "schedutil";
  };

  hardware.enableAllFirmware = true;

  # Disable gnome power management
  services.power-profiles-daemon.enable = false;

  services.auto-cpufreq = {
    enable = true;

    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
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

  ### TLP
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      #CPU_MIN_PERF_ON_AC = 0;
      #CPU_MAX_PERF_ON_AC = 100;
      #CPU_MIN_PERF_ON_BAT = 0;
      #CPU_MAX_PERF_ON_BAT = 20;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 60; # 60 and below it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 90; # 90 and above it stops charging
    };
  };

  ### SYSTEM 76 SCHEDULER
  services.system76-scheduler.settings.cfsProfiles.enable = true;

  ### POWERTOP
  #powerManagement.powertop.enable = true;

  ### ThermalD
  # services.thermald.enable = true;
}
