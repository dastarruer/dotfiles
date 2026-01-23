# https://www.youtube.com/watch?v=pmuubmFcKtg
# also some settings to reduce fan noise while charging
{...}: {
  services.tlp = {
    enable = true;
    settings = {
      # Change from 1 to 0 to stop aggressive boosting on AC
      CPU_BOOST_ON_AC = 0;
      CPU_BOOST_ON_BAT = 0;

      # Use "powersave" or "balanced" even on AC.
      # On Intel/AMD, "powersave" doesn't mean "slow," it just means "efficient."
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # Use "balanced" or "low-power" to tell the BIOS to be quieter
      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # Enable runtime power management
      RUNTIME_PM_ON_AC = "auto";

      START_CHARGE_THRESH_BAT0 = 94;
      STOP_CHARGE_THRESH_BAT0 = 98;
    };
  };

  # Disable GNOMEs power management
  services.power-profiles-daemon.enable = false;
}
