{
  lib,
  pkgs,
  ...
}: {
  # Doesn't declare all kernel params, just the ones for battery saving
  boot.kernelParams = [
    # Enable aggressive SATA link power management (saves power on SSD/HDD).
    "ahci.mobile_lpm_policy=3"

    # Use ACPI alarm for RTC wakeups (more reliable suspend/resume).
    "rtc_cmos.use_acpi_alarm=1"

    # Use AMD’s modern CPU frequency scaling driver (better efficiency on Ryzen).
    "amd_pstate=active"

    # Disable legacy VGA decoding to allow GPU to fully power down.
    "vga_disable_vga=1"

    # Enable usb autosuspend after 5 seconds (https://wiki.archlinux.org/title/Power_management#USB_autosuspend)
    "usbcore.autosuspend=5"

    # Turn on powersaving timeout for audio kernel module (https://wiki.archlinux.org/title/Power_management#Audio)
    "snd_hda_intel.power_save=10"

    # No clue (https://wiki.archlinux.org/title/Power_management#Writeback_Time)
    "vm.dirty_writeback_centisecs=6000"

    # Disable kernel debugger
    "kernel.nmi_watchdog=0"

    # Power saving for integrated gpu
    "amdgpu.dpm=1"
  ];

  boot.blacklistedKernelModules = [
    # Disable ethernet
    "r8169"
  ];

  services.udev.extraRules = lib.concatStringsSep "\n" [
    # USB autosuspend: (https://ivanvojtko.blogspot.com/2016/04/how-to-get-longer-battery-life-on-linux.html)
    ''ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"''

    # Disable wake-on-lan
    ''ACTION=="add", SUBSYSTEM=="net", KERNEL=="eth*", RUN+="${pkgs.ethtool}/bin/ethtool -s %k wol d"''
  ];

  #   I thnk this works?
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
}
