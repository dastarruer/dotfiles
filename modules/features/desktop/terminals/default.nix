{...}: {
  flake.nixosModules.desktop_terminal = {lib, ...}: {
    options.custom = {
      desktop.terminal = lib.mkOption {
        type = lib.types.enum ["kitty" "ghostty" "foot"];
        default = "kitty";
        description = "Set the terminal emulator to be used.";
      };
    };
  };
}
