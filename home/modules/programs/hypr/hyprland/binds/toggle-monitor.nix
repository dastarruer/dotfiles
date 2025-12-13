{pkgs, ...}: {
  wayland.windowManager.hyprland.settings = {
    bind = let
      name1 = "toggle_monitor";
      name2 = "toggle_laptop";
    in [
      "SUPER, Y, exec, ${pkgs.writeShellApplication {
        name = "${name1}";
        runtimeInputs = with pkgs; [
          hyprland
          gawk # awk package
        ];
        text = ''
          # Get the current DPMS state of HDMI-A-1
          STATE=$(hyprctl monitors | grep -A20 "HDMI-A-1" | grep "dpmsStatus" | awk '{print $2}')

          # Toggle based on the current state
          if [ "$STATE" = 1 ]; then
              # If currently on, turn off
              hyprctl dispatch dpms off HDMI-A-1
              echo "HDMI-A-1 turned off"
          else
              # If currently off, turn on
              hyprctl dispatch dpms on HDMI-A-1
              echo "HDMI-A-1 turned on"
          fi
        '';
      }}/bin/${name1}"
      "SUPER+SHIFT, Y, exec, ${pkgs.writeShellApplication {
        name = "${name2}";
        runtimeInputs = with pkgs; [
          hyprland
          gawk # awk package
        ];
        text = ''
          # Get the current DPMS state of eDP-1
          STATE=$(hyprctl monitors | grep -A20 "eDP-1" | grep "dpmsStatus" | awk '{print $2}')

          # Toggle based on the current state
          if [ "$STATE" = 1 ]; then
              # If currently on, turn off
              hyprctl dispatch dpms off eDP-1
          else
              # If currently off, turn on
              hyprctl dispatch dpms on eDP-1
          fi
        '';
      }}/bin/${name2}"
    ];
  };
}
