{...}: {
  flake.nixosModules.hardware = {pkgs, ...}: {
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
          Experimental = true;
        };
      };
    };

    # blueman-manager
    services.blueman.enable = true;

    # Script to connect to my airpods
    nixpkgs.overlays = [
      (final: prev: {
        headphones = prev.writeShellApplication {
          name = "headphones";
          runtimeInputs = with prev; [
            bluez
            libnotify
            blueman
            playerctl
            coreutils
            gnugrep
            gawk
          ];

          text = ''
            HEADPHONES_MAC=70:8C:F2:65:74:82

            # Ensure Bluetooth is on
            bluetoothctl power on

            ACTIVE_PLAYER=$(playerctl -l 2>/dev/null | xargs -I {} playerctl -p {} status 2>/dev/null | grep -q Playing && playerctl -l | head -n 1 || echo "")

            playerctl pause -a 2>/dev/null

            if bluetoothctl info "$HEADPHONES_MAC" 2>/dev/null | grep -q 'Connected: yes'; then
                bluetoothctl disconnect "$HEADPHONES_MAC" >/dev/null
                sleep 1
            fi

            notify-send -t 1500 -i headphones "Connecting to AirPods..."

            if bluetoothctl connect "$HEADPHONES_MAC"; then
                if [ -n "$ACTIVE_PLAYER" ]; then
                    sleep 3
                    playerctl play
                fi
            else
                notify-send -t 2000 -u critical "Connection Failed"
                exit 1
            fi
          '';
        };
      })
    ]
    ;

    home-manager.users.dastarruer = {
      services.mpris-proxy.enable = true;
      services.blueman-applet.enable = true;
    };
  };
}
