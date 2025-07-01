{...}: {
  # Acheive faster reboot times by making sure services can only take up to ten seconds to shut down
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    # Silent Boot
    # https://wiki.archlinux.org/title/Silent_boot
    kernelParams = [
      "quiet"
      "splash"
      "vga=current"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"

      # Remove blinking cursor on console
      "vt.global_cursor_default=0"
    ];
  };
}
