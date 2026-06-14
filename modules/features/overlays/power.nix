{inputs, ...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: let
    gtkshutdown = inputs.gtkshutdown.packages.${pkgs.stdenv.system}.default;

    hmConfig = config.home-manager.users.dastarruer;

    launcher = config.custom.wm.launcher;
    hyprland = config.custom.wm.wm == "hyprland";
    rofi = launcher == "rofi";

    lockCmd = config.custom.wm.locker.command;

    logoutCmd = lib.optionalString hyprland ''${pkgs.hyprland}/bin/hyprctl dispatch "hl.dsp.exit()"'';

    rebootCmd =
      if hyprland
      then "RUST_LOG=trace ${lib.getExe gtkshutdown} --post-cmd 'reboot'"
      else "systemctl reboot";

    shutdownCmd =
      if hyprland
      then "RUST_LOG=trace ${lib.getExe gtkshutdown} --post-cmd 'shutdown -P 0'"
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

          text =
            if launcher == "noctalia"
            then ''
              ${lib.getExe hmConfig.programs.noctalia.package} msg panel-toggle session
            ''
            else ''
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
