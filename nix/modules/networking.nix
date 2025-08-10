{pkgs, ...}: {
  networking = {
    # Define your hostname.
    hostName = "dastarruer";

    # Enable networking
    networkmanager.enable = true;

    # Enable iptables firewall https://nixos.wiki/wiki/Firewall
    firewall.enable = true;
  };

  environment.systemPackages = with pkgs; [
    networkmanager
  ];

  # Enable firmware for wifi cards
  hardware.enableAllFirmware = true;
}
