{lib, ...}: {
  imports = [
    ./kitty.nix
  ];

  options = {
    home-manager.desktop.terminal = lib.mkOption {
      type = lib.types.enum ["kitty"];
      default = "kitty";
      description = "Set the terminal emulator to be used.";
    };
  };
}
