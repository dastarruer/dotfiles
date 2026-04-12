{...}: {
  flake.nixosModules.desktop_terminal = {lib, ...}: {
    options.custom = {
      terminal = lib.mkOption {
        type = lib.types.enum ["kitty" "ghostty"];
        default = "kitty";
        description = "Set the terminal emulator to be used.";
      };
    };
  };
}
