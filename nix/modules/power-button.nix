{...}: {
  # Configure what happens once the power button is pressed
  services.logind.settings.Login = {
    # Suspend system when power button is pressed
    HandlePowerKey = "suspend";
    HandleSuspendKey = "suspend";
    HandleRebootKey = "suspend";
    HandleHibernateKey = "suspend";

    # Reboot system on long press
    HandlePowerKeyLongPress = "reboot";
    HandleSuspendKeyLongPress = "reboot";
    HandleRebootKeyLongPress = "reboot";
    HandleHibernateKeyLongPress = "reboot";
  };
}
