{pkgs, ...}: {
  # Needed for conservation mode on lenovo laptops (charging thresholds basically)
  boot.kernelModules = ["ideapad_laptop"];

  # A systemd service to auto enable conservation mode on my home wifi, and disable it when connected to anything else
  systemd = {
    services.home-battery-threshold = {
      description = "Toggle Lenovo IdeaPad conservation mode based on whether the mouse is plugged in";

      # Start on boot
      wantedBy = ["multi-user.target"];

      # Wait for network access
      after = ["NetworkManager.service"];

      # Run the service before suspend
      before = ["sleep.target"];

      # Lets the service use packages here
      path = with pkgs; [
        usbutils # for lsusb
      ];

      # Enable conservation mode if my mouse is plugged in
      # I usually use my mouse at home when I need conservation mode enabled
      script = ''
        #!/usr/bin/env bash

        BATTERY_PATH="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
        MOUSE_ID="046d:c077"

        if lsusb | grep -iq "$MOUSE_ID"; then
            echo 1 | tee "$BATTERY_PATH"
            echo "toggle conservation mode on"
        else
            echo 0 | tee "$BATTERY_PATH"
            echo "toggle conservation mode off"
        fi
      '';

      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = 10;
      };
    };

    timers.home-battery-threshold = {
      wantedBy = ["multi-user.target"];
      timerConfig = {
        # Trigger every minute
        OnCalendar = "minutely";
        Unit = "home-battery-threshold.service";
      };
    };
  };
}
