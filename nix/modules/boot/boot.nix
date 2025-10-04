{pkgs, ...}: {
  # Acheive faster reboot times by making sure services can only take up to ten seconds to shut down
  systemd.settings.Manager = {
    # How long to wait before forcibly killing a service when stopping it
    DefaultTimeoutStopSec = "10s";

    # Whether systemd should add implicit dependencies like 'After=basic.target'
    DefaultDependencies = "yes";

    # Maximum time to wait for a job (e.g. starting/stopping a unit) before it's considered failed
    JobTimeoutSec = "10s";

    # Time window for counting service start failures (used with StartLimitBurst)
    DefaultStartLimitIntervalSec = "10s";
  };

  # Acheive faster boot times by not connecting to internet on boot
  systemd.network.wait-online.enable = false;

  # Bootloader.
  boot = {
    # Spalsh screen
    plymouth = {
      enable = true;

      # Set the theme of plymouth
      theme = "cuts_alt";

      themePackages = with pkgs; [
        # Use an override so it doesn't install every theme
        (adi1090x-plymouth-themes.override {
          selected_themes = ["cuts_alt"];
        })
      ];
    };

    # Bootloader
    loader = {
      # Set a timeout of 0 so it skips the nix generation menu entirely
      # If you're having issues: https://github.com/NixOS/nixpkgs/issues/266147
      timeout = 0;

      # Enable systemd boot which is faster
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Get the latest kernel packages
    kernelPackages = pkgs.linuxPackages_testing;

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

      # Enable deep sleep
      "mem_sleep_default=deep"

      # Disable checksum verification of microcode updates or something do you really care?
      "microcode.amd_sha_check=off"
    ];

    # https://discourse.nixos.org/t/removing-persistent-boot-messages-for-a-silent-boot/14835
    consoleLogLevel = 0;
    initrd.verbose = false;
  };
}
