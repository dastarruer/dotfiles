{inputs, ...}: {
  flake.nixosModules.hardware = {
    config,
    pkgs,
    ...
  }: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

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

    # Add script to control wifi w rofi
    # Add script to control wifi w rofi
    nixpkgs.overlays = [
      (final: prev: {
        wifi = prev.writeShellApplication {
          name = "wifi-menu";
          runtimeInputs = with prev; [
            coreutils
            libnotify
            networkmanager
            gnused
            rofi
          ];

          text = ''
            notify-send "Getting list of available Wi-Fi networks..."

            # Get a list of available wifi connections and morph it into a nice-looking list
            wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | \
                        sed 1d | \
                        sed 's/  */ /g' | \
                        sed -E "s/WPA*.?\S/ /g" | \
                        sed "s/^--/ /g" | \
                        sed "s/  //g" | \
                        sed "/--/d")

            connected=$(nmcli -fields WIFI g)

            if [[ "$connected" =~ "enabled" ]]; then
                toggle="󰖪  Disable Wi-Fi"
            elif [[ "$connected" =~ "disabled" ]]; then
                toggle="󰖩  Enable Wi-Fi"
            fi

            # Use rofi to select wifi network
            chosen_network=$(echo -e "$toggle\n$wifi_list" | uniq -u | rofi -dmenu -i -selected-row 1 -p "Wi-Fi SSID: ")

            # Exit if nothing is selected
            if [ "$chosen_network" = "" ]; then
                exit
            fi

            # Get name of connection (stripping the icon prefix)
            read -r chosen_id <<< "''${chosen_network: 3}"

            if [ "$chosen_network" = "󰖩  Enable Wi-Fi" ]; then
                nmcli radio wifi on
            elif [ "$chosen_network" = "󰖪  Disable Wi-Fi" ]; then
                nmcli radio wifi off
            else
                success_message="You are now connected to the Wi-Fi network \"$chosen_id\"."

                # Check if connection is already saved
                saved_connections=$(nmcli -g NAME connection)

                if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
                    nmcli connection up id "$chosen_id" | grep "successfully" && \
                    notify-send "Connection Established" "$success_message"
                else
                    # Prompt for password if the network is secured (indicated by the lock icon)
                    if [[ "$chosen_network" =~ "" ]]; then
                        wifi_password=$(rofi -dmenu -password -p "Password: ")
                    fi

                    nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully" && \
                    notify-send "Connection Established" "$success_message"
                fi
            fi
          '';
        };
      })
    ];

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

    # Kinda fixes long boot times? Not really
    systemd.network.wait-online = {
      enable = false;
      timeout = 1;
    };

    # Enable firmware for wifi cards
    hardware.enableAllFirmware = true;
  };
}
