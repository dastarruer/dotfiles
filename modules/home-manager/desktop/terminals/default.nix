{lib, ...}: {
  imports = [
    ./kitty.nix
    ./ghostty.nix
  ];

  options = {
    home-manager.desktop.terminal = lib.mkOption {
      type = lib.types.enum ["kitty" "ghostty"];
      default = "kitty";
      description = "Set the terminal emulator to be used.";
    };
  };
}
