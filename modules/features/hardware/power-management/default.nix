{...}: {
  flake.nixosModules.hardware = {...}: {
    # Enable NixOS power management hooks (basic integration).
    powerManagement = {
      enable = true;
      cpuFreqGovernor = "powersave";
    };

    # Doesn't declare all kernel params, just the ones for battery saving
    boot.kernelParams = [
      # Enable aggressive SATA link power management (saves power on SSD/HDD).
      "ahci.mobile_lpm_policy=3"

      # Use ACPI alarm for RTC wakeups (more reliable suspend/resume).
      "rtc_cmos.use_acpi_alarm=1"

      # Enable usb autosuspend after 5 seconds (https://wiki.archlinux.org/title/Power_management#USB_autosuspend)
      # "usbcore.autosuspend=5"
      # Disable this, why did i enable it in the first place?
      "usbcore.autosuspend=-1"

      # Turn on powersaving timeout for audio kernel module (https://wiki.archlinux.org/title/Power_management#Audio)
      "snd_hda_intel.power_save=10"

      # No clue (https://wiki.archlinux.org/title/Power_management#Writeback_Time)
      "vm.dirty_writeback_centisecs=6000"

      # Disable kernel debugger
      "kernel.nmi_watchdog=0"
    ];

    # Powersaving for wifi
    networking.networkmanager.settings.connection."wifi.powersave" = 3;

    systemd.tmpfiles.rules = [
      # Write "balance_power" to all CPU energy performance preference files.
      # This biases the CPU toward energy savings at idle while still scaling up when needed.
      "w /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference - - - - balance_power"
    ];

    # Enables System76's scheduler tweaks:
    # - Gives foreground/interactive tasks higher CPU priority
    # - Improves desktop responsiveness (especially useful on laptops).
    services.system76-scheduler.settings.cfsProfiles.enable = true;

    # I thnk this works?
    systemd.services.amdgpu-power = {
      description = "Set AMD GPU to battery mode";
      after = ["multi-user.target"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "/bin/sh -c 'echo battery > /sys/class/drm/card1/device/power_dpm_state'";
        RemainAfterExit = true;
      };
    };
  };
}
