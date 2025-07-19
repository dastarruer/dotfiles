{...}: {
  # Better battery life
  services.auto-cpufreq.enable = true;

  services.logind = {
    # Suspend system when power button is pressed
    suspendKey = "suspend";

    # Reboot system on long press
    suspendKeyLongPress = "reboot";

    # Auto-suspend after 10 minutes
    extraConfig = ''
      IdleAction=suspend
      IdleActionSec=10min
    '';
  };
}
