{...}: {
  nixpkgs.overlays = [
    (final: prev: let
      # 1. Define a helper function to create the script
      mkMonitorToggle = monitorName:
        prev.writeShellApplication {
          name = "toggle-${monitorName}";

          runtimeInputs = with prev; [
            hyprland
            gawk
            gnugrep
          ];

          text = ''
            STATE=$(hyprctl monitors | grep -A20 "${monitorName}" | grep "dpmsStatus" | awk '{print $2}')
            if [ "$STATE" = 1 ]; then
                hyprctl dispatch dpms off "${monitorName}"
            else
                hyprctl dispatch dpms on "${monitorName}"
            fi
          '';
        };
    in {
      # 2. Use the helper to define your packages
      toggle-hdmi = mkMonitorToggle "HDMI-A-1";
      toggle-laptop = mkMonitorToggle "eDP-1";
    })
  ];
}
