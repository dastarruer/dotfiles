{pkgs, ...}: {
  # Needed for conservation mode on lenovo laptops (charging thresholds basically)
  boot.kernelModules = ["ideapad_laptop"];

  # A systemd service to auto enable conservation mode on my home wifi, and disable it when connected to anything else
  systemd = {
    services.conservation-mode = {
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

    timers.conservation-mode = {
      wantedBy = ["multi-user.target"];
      timerConfig = {
        # Trigger every minute
        OnCalendar = "minutely";
      };
    };
  };
}
