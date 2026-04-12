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
    environment.systemPackages = [
      (pkgs.writeShellApplication {
        name = "headphones";
        runtimeInputs = with pkgs; [
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
          bluetoothctl power on || {
              notify-send -t 1000 -u low -i dialog-warning "Failed to turn on Bluetooth, opening Blueman..."
              blueman-manager &
              exit 1
          }
          ACTIVE_PLAYER=$(playerctl -l | while read -r player; do
              if playerctl -p "$player" status 2>/dev/null | grep -q Playing; then
                  echo "$player"
                  break
              fi
          done)
          playerctl pause -a
          if bluetoothctl info "$HEADPHONES_MAC" | grep 'Connected: yes' -q; then
              notify-send -t 1500 -u low -i dialog-warning "Restarting Bluetooth..."
              bluetoothctl power off
              bluetoothctl power on
          fi
          notify-send -t 1500 -u low -i headphones "Connecting to headphones..."
          bluetoothctl connect "$HEADPHONES_MAC" || {
              notify-send -t 1500 -u low -i dialog-error "Failed to connect headphones. Please try again."
              exit 1
          }
          if [ -n "$ACTIVE_PLAYER" ]; then
              sleep 2
              playerctl -p "$ACTIVE_PLAYER" play
          fi
        '';
      })
    ];

    home-manager.users.dastarruer = {
      services.mpris-proxy.enable = true;
    };
  };
}
