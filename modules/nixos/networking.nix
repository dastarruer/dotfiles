{
  config,
  pkgs,
  # lib,
  ...
}: {
  sops.secrets = {
    "wifi/home/ssid" = {};
    "wifi/home/psk" = {};
  };

  networking = {
    # Define your hostname.
    hostName = "dastarruer";

    # Enable networking
    networkmanager = {
      enable = true;

      # Declare network connections
      # Can be found at /run/NetworkManager/system-connections
      ensureProfiles = {
        environmentFiles = [
          config.sops.secrets."wifi/home/ssid".path
          config.sops.secrets."wifi/home/psk".path
        ];

        profiles = {
          "home" = {
            connection = {
              id = "home";
              type = "wifi";
              autoconnect = true;
              interface-name = "wlp2s0";
            };

            wifi = {
              mode = "infrastructure";
              ssid = "$HOME_SSID";
            };

            wifi-security = {
              key-mgmt = "wpa-psk";
              psk = "$HOME_PSK";
            };

            ipv4 = {
              method = "auto";
            };

            ipv6 = {
              addr-gen-mode = "stable-privacy";
            };
          };
        };
      };
    };

    # Enable iptables firewall https://nixos.wiki/wiki/Firewall
    firewall.enable = true;

    useDHCP = false;
    dhcpcd.enable = false;

    usePredictableInterfaceNames = true;
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      Domains = ["~."];
      DNSSEC = true;
      FallbackDNS = ["1.1.1.1" "9.9.9.9"];
    };
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
  hardware.enableAllFirmware = false;
}
