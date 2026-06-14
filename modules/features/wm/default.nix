{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;
    lockerCommands = {
      hyprlock = "${lib.getExe hmConfig.programs.hyprlock.package}";
      swaylock = "${lib.getExe hmConfig.programs.swaylock.package}";
      noctalia = "${lib.getExe hmConfig.programs.noctalia.package} msg session lock";
      none = "true"; # Fallback/do nothing command
    };
  in {
    options.custom.wm = {
      wm = lib.mkOption {
        type = lib.types.enum ["hyprland"];
        default = "hyprland";
        description = "Set the window manager to be used.";
      };
      wayland = lib.mkOption {
        type = lib.types.bool;
        readOnly = true;
        default = builtins.elem config.custom.wm.wm ["hyprland"];
        description = "Whether the selected window manager is a Wayland compositor (derived automatically).";
      };
      locker = {
        kind = lib.mkOption {
          type = lib.types.enum ["hyprlock" "swaylock" "noctalia" "none"];
          default = "hyprlock";
          description = "Set the screen locker to be used.";
        };
        command = lib.mkOption {
          type = lib.types.str;
          readOnly = true;
          description = "The absolute path/command of the chosen locker.";
        };
      };
      bar.bar = lib.mkOption {
        type = lib.types.enum ["waybar" "noctalia" "none"];
        default = "waybar";
        description = "Set the bar to be used.";
      };
      notifications.daemon = lib.mkOption {
        type = lib.types.enum ["dunst" "noctalia" "none"];
        default = "dunst";
        description = "Set the notification daemon to be used.";
      };
      launcher = lib.mkOption {
        type = lib.types.enum ["rofi" "noctalia" "sherlock" "none"];
        default = "rofi";
        description = "Set the launcher to be used.";
      };
      idle-daemon = lib.mkOption {
        type = lib.types.enum ["hypridle" "noctalia" "none"];
        default = "hypridle";
        description = "Set the idle daemon to be used.";
      };
      night-light = lib.mkOption {
        type = lib.types.enum ["hyprsunset" "noctalia" "none"];
        default = "hyprsunset";
        description = "Set the night-light filter utility to be used.";
      };
      wallpaper-daemon = lib.mkOption {
        type = lib.types.enum ["awww" "noctalia" "none"];
        default = "awww";
        description = "Set the wallpaper daemon to be used.";
      };
      clipboard = lib.mkOption {
        type = lib.types.enum ["cliphist" "noctalia" "none"];
        default = "cliphist";
        description = "Set the clipboard manager to be used.";
      };
    };

    config = {
      custom.wm.locker.command = lockerCommands.${config.custom.wm.locker.kind};
    };
  };
}
