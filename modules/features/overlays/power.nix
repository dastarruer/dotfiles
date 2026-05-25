{inputs, ...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;

    gtkshutdown = inputs.gtkshutdown.packages.${pkgs.stdenv.system}.default;
    hyprland = hmConfig.wayland.windowManager.hyprland;
    locker = config.custom.wm.locker;
    rofi = hmConfig.programs.rofi;

    lockCmd =
      if locker == "hyprlock"
      then "${lib.getExe pkgs.hyprlock}"
      else if locker == "swaylock"
      then "${lib.getExe pkgs.swaylock}"
      else "true";

    logoutCmd = lib.optionalString hyprland.enable ''${pkgs.hyprland}/bin/hyprctl dispatch "hl.dsp.exit()"'';

    rebootCmd =
      if hyprland.enable
      then "${lib.getExe gtkshutdown} --post-cmd 'reboot'"
      else "systemctl reboot";

    shutdownCmd =
      if hyprland.enable
      then "${lib.getExe gtkshutdown} --post-cmd 'shutdown -P 0'"
      else "systemctl poweroff";

    launcherCmd =
      if rofi
      then "${lib.getExe pkgs.rofi} -dmenu -i -p 'Power Menu:'"
      else "cat";
  in {
    # For test purposes
    environment.systemPackages = [gtkshutdown];

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
                  systemctl suspend
                  ;;
              " Reboot")
                  ${rebootCmd}
                  ;;
              " Shutdown")
                  ${shutdownCmd}
                  ;;
              *)
                  exit 0
                  ;;
            esac
          '';
        };
      })
    ];
  };
}
