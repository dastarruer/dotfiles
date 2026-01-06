{
  config,
  lib,
  pkgs,
  ...
}: let
  hyprland = config.home-manager.window-manager.hypr.hyprland;
  hyprlock = config.home-manager.window-manager.hypr.hyprlock;
  rofi = config.home-manager.window-manager.rofi;

  lockCmd = lib.optionalString hyprlock.enable "${lib.getExe pkgs.hyprlock}";
  logoutCmd = lib.optionalString hyprland.enable "${pkgs.hyprland}/bin/hyprctl dispatch exit";
  launcherCmd =
    if rofi.enable
    then "${lib.getExe pkgs.rofi} -dmenu -i -p 'Power Menu:'"
    else "cat";
in {
  nixpkgs.overlays = [
    (final: prev: {
      power = prev.writeShellApplication {
        name = "power";

        runtimeInputs = with prev; [
          systemd
          coreutils
        ];

        text = ''
          OPTIONS=" Lock\n󰗽 Logout\n󰥔 Suspend\n Reboot\n Shutdown"

          CHOICE=$(echo -e "$OPTIONS" | ${launcherCmd})

          case "$CHOICE" in
            " Lock")
                ${lockCmd} & disown
                ;;
            "󰗽 Logout")
                ${logoutCmd}
                ;;
            "󰥔 Suspend")
                # Ensure pause-all exists in your pkgs overlay or scope
                ${lib.getExe pkgs.pause-all}
                ${lockCmd} & disown
                sleep 1
                systemctl suspend
                ;;
            " Reboot")
                systemctl reboot
                ;;
            " Shutdown")
                systemctl poweroff
                ;;
            *)
                exit 0
                ;;
          esac
        '';
      };
    })
  ];
}
