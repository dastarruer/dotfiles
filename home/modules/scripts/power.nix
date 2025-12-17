{...}: {
  nixpkgs.overlays = [
    (final: prev: {
      power = prev.writeShellApplication {
        name = "power";
        runtimeInputs = with prev; [
          rofi
          hyprlock
          hyprland # hyprctl
          systemd # systemctl
          coreutils # echo
        ];
        text = let
          lockCommand = "hyprlock";
          logoutCommand = "hyprctl dispatch exit";
        in ''
          # Define options
          OPTIONS=" Lock\n󰗽 Logout\n󰥔 Suspend\n Reboot\n Shutdown"

          # Show the menu and get the user's choice
          CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Power Menu:")

          case "$CHOICE" in
          " Lock")
              ${lockCommand} & disown
              ;;
          "󰗽 Logout")
              ${logoutCommand}
              ;;
          "󰥔 Suspend")
              "$HOME"/bin/pause-all.sh
              # TODO: Create systemd service to auto-lock on suspend
              ${lockCommand} & disown && sleep 1 && systemctl suspend
              ;;
          " Reboot")
              systemctl reboot
              ;;
          " Shutdown")
              systemctl poweroff
              ;;
          *)
              exit 1
              ;;
          esac
        '';
      };
    })
  ];
}
