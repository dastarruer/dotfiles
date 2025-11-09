{pkgs, ...}: {
  # Needed for conservation mode on lenovo laptops (charging thresholds basically)
  boot.kernelModules = ["ideapad_laptop"];

  # A systemd service to auto enable conservation mode on my home wifi, and disable it when connected to anything else
  systemd.services.conservation-mode = {
    # Lets the service use packages here
    path = with pkgs; [
      usbutils # for lsusb
      bash
    ];

    description = "Toggle Lenovo IdeaPad conservation mode based on whether the mouse is plugged in";

    # Start on boot
    wantedBy = ["multi-user.target"];

    # Wait for network access
    after = ["NetworkManager.service"];

    # Run the service before suspend
    before = ["sleep.target"];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = ./scripts/conservation-mode.sh;
    };
  };

  systemd.timers.conservation-mode = {
    wantedBy = ["multi-user.target"];
    timerConfig = {
      # Trigger every minute
      OnCalendar = "minutely";
    };
  };

  # services.udev.extraRules = let
  #   bash = "${pkgs.bash}/bin/bash";
  #   tee = "${pkgs.coreutils}/bin/tee";
  #   echo = "${pkgs.coreutils}/bin/echo";
  #   cat = "${pkgs.coreutils}/bin/cat";
  #   batteryPath = "/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode";
  # in ''
  #   # Toggle conservation mode on AC state change
  #   ACTION=="change", SUBSYSTEM=="power_supply", RUN+="${bash} -c 'current=\$(${cat} ${batteryPath}); if [ \"\$current\" -eq 0 ]; then new=1; else new=0; fi; ${echo} \$new | ${tee} ${batteryPath}; ${echo} toggled conservation mode to \$new'"
  # '';
}
