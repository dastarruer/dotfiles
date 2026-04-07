{...}: {
  flake.nixosModules.wm = {lib, ...}: {
    home-manager.users.dastarruer = {
      options.custom = {
        wm.locker = lib.mkOption {
          type = lib.types.enum ["hyprlock" "swaylock" "none"];
          default = "swaylock";
          description = "Set the screen locker to be used.";
        };
      };
    };
  };
}
