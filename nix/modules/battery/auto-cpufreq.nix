{...}: {
  services.auto-cpufreq = {
    enable = true;

    settings = {
      # Settings for when running on battery
      battery = {
        governor = "powersave"; # Use the "powersave" CPU governor to reduce frequency scaling.
        turbo = "never"; # Disable CPU turbo boost to save power and lower temps.

        # this doesnt work for whatever reason, ive declared a systemd service to turn on conservation mode, which is the same thing but for lenovo laptops
        # enable_thresholds = true;
        # start_threshold = 40;
        # stop_threshold = 80;
      };

      # Settings for when running on AC power (charger plugged in)
      charger = {
        governor = "performance"; # Run CPU in "performance" mode for maximum responsiveness.
        turbo = "auto"; # Allow turbo boost when on AC power.
      };
    };
  };
}
