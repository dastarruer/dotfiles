{
  config,
  lib,
  pkgs,
  ...
}: let
  hyprland = config.home-manager.window-manager.hyprland;
  locker = config.home-manager.window-manager.screen-locker;
  rofi = config.home-manager.window-manager.rofi;

  lockCmd =
    if locker == "hyprlock"
    then "${lib.getExe pkgs.hyprlock}"
    else if locker == "swaylock"
    then "${lib.getExe pkgs.swaylock}"
    else "true";

  logoutCmd = lib.optionalString hyprland.enable "${lib.getExe pkgs.hyprshutdown}";

  launcherCmd =
    if rofi.enable
    then "${lib.getExe pkgs.rofi} -dmenu -i -p 'Power Menu:'"
    else "cat";
in {
  nixpkgs.overlays = [
    (final: prev: {
      power = prev.writeShellApplication {
        name = "power";

        runtimeInputs = with prev;
          [
            systemd
            coreutils
            gnugrep
          ]
          ++ lib.optionals hyprland.enable [prev.hyprshutdown];

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
                systemctl suspend
                ;;
            " Reboot")
                ${
            if hyprland.enable
            then ''hyprshutdown -t "Rebooting... Please wait..." --post-cmd 'systemctl reboot' ''
            else "systemctl reboot"
          }
                ;;
            " Shutdown")
               ${
            if hyprland.enable
            then ''hyprshutdown -t "Shutting down... Please wait..." --post-cmd 'systemctl poweroff' ''
            else "systemctl reboot"
          }
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
