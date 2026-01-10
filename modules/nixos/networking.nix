{pkgs, ...}: {
  networking = {
    # Define your hostname.
    hostName = "dastarruer";

    # Enable networking
    networkmanager.enable = true;

    # Enable iptables firewall https://nixos.wiki/wiki/Firewall
    firewall.enable = true;

    # DNS servers
    nameservers = [
      "1.1.1.1" # Cloudflare (fast + privacy focused)
      "9.9.9.9" # Quad9 (blocks malicious domains)
    ];

    # idk what this does
    usePredictableInterfaceNames = true;
  };

  environment.systemPackages = with pkgs; [
    networkmanager
  ];

  # Kinda fixes long boot times? Not realyl
  systemd.network.wait-online = {
    enable = false;
    timeout = 1;
  };

  # Enable firmware for wifi cards
  hardware.enableFirmware = true;
}
