{...}: {
  # Better battery life
  services.auto-cpufreq.enable = true;

  services.logind = {
    # Suspend system when power button is pressed
    powerKey = "suspend";
    suspendKey = "suspend";
    rebootKey = "suspend";
    hibernateKey = "suspend";

    # Reboot system on long press
    powerKeyLongPress = "reboot";
    suspendKeyLongPress = "reboot";
    rebootKeyLongPress = "reboot";
    hibernateKeyLongPress = "reboot";

    # Auto-suspend after 10 minutes
    extraConfig = ''
      IdleAction=suspend
      IdleActionSec=10min
    '';
  };
}
