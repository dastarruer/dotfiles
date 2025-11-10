{pkgs, ...}: {
  # Needed for conservation mode on lenovo laptops (charging thresholds basically)
  boot.kernelModules = ["ideapad_laptop"];

  # A udev rule to toggle conservation mode on monitor connect
  services.udev.extraRules = let
    tee = "${pkgs.coreutils}/bin/tee";
    echo = "${pkgs.coreutils}/bin/echo";
    cat = "${pkgs.coreutils}/bin/cat";
    batteryPath = "/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode";

    # A shell script to toggle conservation mode on and off
    toggleConservation = pkgs.writeShellScript "toggle-conservation-mode" ''
      #!/run/current-system/sw/bin/bash

      # Get the current status of conservation mode, where 1 is on and 0 is off
      current=$(${cat} ${batteryPath})

      if [ "$current" -eq 0 ]; then
        new=1
      else
        new=0
      fi

      ${echo} $new | ${tee} ${batteryPath}
      ${echo} "Toggled conservation mode to $new"
    '';
  in
    # https://wiki.archlinux.org/title/Udev
    # use udevadm monitor --property --udev command to get all these values
    ''
      ACTION=="change", SUBSYSTEM=="drm", ENV{DEVNAME}=="/dev/dri/card1", RUN+="${toggleConservation}"
    '';

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
