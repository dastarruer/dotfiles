{...}: {
  hardware.bluetooth = {
    # Enable support for Bluetooth
    enable = true;

    # Powers up the default Bluetooth controller on boot
    powerOnBoot = true;

    # Set bluetooth settings
    settings = {
      General = {
        # For airpods (https://gist.github.com/aidos-dev/b49078c1d8c6bb1621e4ac199d18213b)
        ControllerMode = "bredr";

        # Lets devices connect faster at the cost of battery life
        # FastConnectable = true;
      };
    };
  };

  # blueman-manager
  services.blueman.enable = true;
}
