{
  pkgs,
  ...
}: {
  home.packages = [pkgs.evtest pkgs.libnotify];

  systemd.user.services.caps-lock-monitor = {
    Unit = {
      Description = "Caps Lock Event Monitor";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };

    Service = {
      ExecStart = let
        name = "caps-lock-notify";
      in "${pkgs.writeShellApplication {
        name = "${name}";

        runtimeInputs = with pkgs; [
          evtest
          libnotify
        ];

        # https://www.reddit.com/r/linux4noobs/comments/11z5uqq/universal_caps_lock_status_notification/
        text = ''
          # Path to your keyboard
          # This path seems to work just fine for me
          KEYBOARD="/dev/input/by-path/platform-i8042-serio-0-event-kbd"

          # We use a regex or partial match to handle both ON and OFF
          # Value 1 = ON, Value 0 = OFF
          evtest "$KEYBOARD" | while read -r line; do
            if [[ "$line" == *"code 1 (LED_CAPSL), value 1"* ]]; then
              notify-send -t 1000 -u low "Caps Lock ON" -i keyboard
            elif [[ "$line" == *"code 1 (LED_CAPSL), value 0"* ]]; then
              notify-send -t 1000 -u low "Caps Lock OFF" -i keyboard
            fi
          done
        '';
      }}/bin/${name}";
      Restart = "always";
      RestartSec = 3;
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
