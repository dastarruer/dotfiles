{lib, ...}: {
  imports = [
    ./hyprlock
    ./swaylock
  ];

  options = {
    home-manager.window-manager.screen-locker = lib.mkOption {
      type = lib.types.enum ["hyprlock" "swaylock" "none"];
      default = "swaylock";
      description = "Set the screen locker to be used.";
    };
  };
}
