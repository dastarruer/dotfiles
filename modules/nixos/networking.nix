{
  config,
  pkgs,
  ...
}: {
  sops.secrets = {
    home_wifi_id = {};
    home_wifi_password = {};
  };

  networking = {
    # Define your hostname.
    hostName = "dastarruer";

    # Enable networking
    networkmanager = {
      enable = true;

      # Declare network connections
      # Can be found at /etc/NetworkManager/system-connections
      ensureProfiles.profiles = {
        home-wifi = {
          connection = {
            id = builtins.readFile config.sops.secrets.home_wifi_id.path;
            interface-name = "wlp2s0";
            type = "wifi";
          };

          wifi = {
            mode = "infrastructure";
            ssid = builtins.readFile config.sops.secrets.home_wifi_id.path;
          };

          ipv4 = {
            method = "auto";
          };

          ipv6 = {
            addr-gen-mode = "default";
            dns-search = "";
            method = "auto";
          };
        };
      };
    };

    # Enable iptables firewall https://nixos.wiki/wiki/Firewall
    firewall.enable = true;

    # DNS servers
    nameservers = [
      "1.1.1.1" # Cloudflare (fast + privacy focused)
      "9.9.9.9" # Quad9 (blocks malicious domains)
    ];

    usePredictableInterfaceNames = true;
  };

  # Allow user to configure networkmanager (https://wiki.nixos.org/wiki/NetworkManager#Installation)
  users.users.dastarruer.extraGroups = ["networkmanager"];

  environment.systemPackages = with pkgs; [
    networkmanager
  ];

  # Kinda fixes long boot times? Not really
  systemd.network.wait-online = {
    enable = false;
    timeout = 1;
  };

  # Enable firmware for wifi cards
  hardware.enableAllFirmware = true;
}
