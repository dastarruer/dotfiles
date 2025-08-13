{
  pkgs,
  config,
  ...
}: {
  # Most of these settings are from here: https://discourse.nixos.org/t/battery-life-still-isnt-great/41188

  # Enable NixOS power management hooks (basic integration).
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

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

        # this doesnt work for whatever reason
        # enable_thresholds = true;
        # start_threshold = 40;
        # stop_threshold = 80;
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

    # Enable usb autosuspend after 120 seconds
    "usbcore.autosuspend=120"
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

  # Needed for conservation mode on lenovo laptops (charging thresholds basically)
  boot.kernelModules = ["ideapad_laptop"];

  # Get the wifi ssid
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.keyFile = "/home/dastarruer/.config/sops/age/keys.txt";

    secrets = {
      home_wifi = {};
    };
  };

  # A systemd service to auto enable conservation mode on my home wifi, and disable it when connected to anything else
  systemd.services.home-battery-threshold = {
    description = "Toggle Lenovo IdeaPad conservation mode based on home Wi-Fi";

    # Start on boot
    wantedBy = ["multi-user.target"];

    # Wait for network access
    after = ["NetworkManager.service"];
    wants = ["NetworkManager.service"];

    script = ''
      #!/usr/bin/env bash
      export PATH=/run/current-system/sw/bin:/usr/bin:/bin

      # This took forever to figure out but you have to cat the path to get the value
      HOME_SSID="$(cat ${config.sops.secrets.home_wifi.path})"
      BATTERY_PATH="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"

      while true; do
          SSID=$(nmcli -t -f active,ssid dev wifi | \
                grep '^yes' | \
                cut -d: -f2)
          if [ "$SSID" = "$HOME_SSID" ]; then
              echo 1 > "$BATTERY_PATH"
              echo "conservation mode activated"
          else
              echo 0 > "$BATTERY_PATH"
              echo "conservation mode deactivated"
          fi
          sleep 1
      done
    '';

    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSec = 10;
    };
  };
}
