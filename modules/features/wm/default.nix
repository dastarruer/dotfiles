{...}: {
  flake.nixosModules.wm = {
    config,
    lib,
    ...
  }: {
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

      locker = lib.mkOption {
        type = lib.types.enum ["hyprlock" "swaylock" "none"];
        default = "hyprlock";
        description = "Set the screen locker to be used.";
      };
      bar = lib.mkOption {
        type = lib.types.enum ["waybar" "none"];
        default = "waybar";
        description = "Set the bar to be used.";
      };
      notifications.daemon = lib.mkOption {
        type = lib.types.enum ["dunst" "none"];
        default = "dunst";
        description = "Set the notification daemon to be used.";
      };
      launcher = lib.mkOption {
        type = lib.types.enum ["rofi" "sherlock" "none"];
        default = "rofi";
        description = "Set the launcher to be used.";
      };
      idle-daemon = lib.mkOption {
        type = lib.types.enum ["hypridle" "none"];
        default = "hypridle";
        description = "Set the idle daemon to be used.";
      };
      night-light = lib.mkOption {
        type = lib.types.enum ["hyprsunset" "none"];
        default = "hyprsunset";
        description = "Set the night-light filter utility to be used.";
      };
    };

    config.home-manager.users.dastarruer = {config, ...}: {
      programs.quickshell.enable = true;
      # just do this manually
      # home.file.".config/quickshell".source = config.lib.file.mkOutOfStoreSymlink "./quickshell";
    };
  };
}
