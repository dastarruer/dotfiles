{...}: {
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

    # Suspend laptop if lid is closed, and if is connected to monitor then don't do anything
    HandleLidSwitch = "ignore"; #"suspend";
    HandleLidSwitchDocked = "ignore";
  };
}
