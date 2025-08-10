{...}: {
  # Configure what happens once the power button is pressed
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
  };
}
