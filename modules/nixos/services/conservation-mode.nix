{pkgs, ...}: {
  # Needed for conservation mode on lenovo laptops (charging thresholds basically)
  boot.kernelModules = ["ideapad_laptop"];

  # It seems to work only when using a systemd service rather than a standalone script
  systemd.services.toggle-conservation = {
    description = "Toggle conservation mode based on HDMI connection";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "forking";
      ExecStart = let
        tee = "${pkgs.coreutils}/bin/tee";
        echo = "${pkgs.coreutils}/bin/echo";
        grep = "${pkgs.gnugrep}/bin/grep";
        batteryPath = "/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode";

        # A shell script to toggle conservation mode on and off
        toggleConservation = pkgs.writeShellScript "toggle-conservation-mode" ''
          #!/run/current-system/sw/bin/bash

          # sleep 5
          # Check if a monitor is disconnected
          if ${grep} -q "disconnected" /sys/class/drm/card1-DP-1/status; then
            new=0
          else
            new=1
          fi

          # Write the value
          ${echo} $new | ${tee} ${batteryPath}
        '';
      in "${toggleConservation}";
    };
  };

  # A udev rule to toggle conservation mode on monitor connect
  services.udev.extraRules =
    # https://wiki.archlinux.org/title/Udev
    # https://discourse.nixos.org/t/starting-user-system-service-from-udev-rules/5962 (but as a root service instead)
    # use udevadm monitor --property --udev command to get all these values
    ''
      ACTION=="change", SUBSYSTEM=="drm", ENV{HOTPLUG}=="1", TAG+="systemd", ENV{SYSTEMD_WANTS}+="toggle-conservation.service"
    '';

  # OLD BAD NOT GOOD
  # A systemd service to auto enable conservation mode on my home wifi, and disable it when connected to anything else
  # systemd.services.conservation-mode = {
  #   # Lets the service use packages here
  #   path = with pkgs; [
  #     usbutils # for lsusb
  #     bash
  #   ];

  #   description = "Toggle Lenovo IdeaPad conservation mode based on whether the mouse is plugged in";

  #   # Start on boot
  #   wantedBy = ["multi-user.target"];

  #   # Wait for network access
  #   after = ["NetworkManager.service"];

  #   # Run the service before suspend
  #   before = ["sleep.target"];

  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = ./scripts/conservation-mode.sh;
  #   };
  # };

  # systemd.timers.conservation-mode = {
  #   wantedBy = ["multi-user.target"];
  #   timerConfig = {
  #     # Trigger every minute
  #     OnCalendar = "minutely";
  #   };
  # };
}
