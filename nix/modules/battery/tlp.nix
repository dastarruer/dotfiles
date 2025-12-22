# https://www.youtube.com/watch?v=pmuubmFcKtg
{...}: {
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      START_CHARGE_THRESH_BAT0 = 94;
      STOP_CHARGE_THRESH_BAT0 = 98;
    };
  };

  # Disable GNOMEs power management
  services.power-profiles-daemon.enable = false;
}
