{pkgs, ...}: {
  # Define your hostname.
  networking.hostName = "dastarruer";

  # Enable networking
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    networkmanager
  ];

  # Enable firmware for wifi cards
  hardware.enableAllFirmware = true;
}
