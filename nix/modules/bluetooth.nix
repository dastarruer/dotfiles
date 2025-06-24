{...}: {
  hardware.bluetooth = {
    # Enable support for Bluetooth
    enable = true;

    # powers up the default Bluetooth controller on boot
    powerOnBoot = true;

    # Set bluetooth settings
    settings = {
      # Because it says I should do this for airpods here: https://gist.github.com/aidos-dev/b49078c1d8c6bb1621e4ac199d18213b
      General = {
        ControllerMode = "bredr";
      };
    };
  };

  # blueman-manager
  services.blueman.enable = true;
}
