{...}: {
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

    # Enable usb autosuspend after 120 seconds
    "usbcore.autosuspend=120"
  ];
}
