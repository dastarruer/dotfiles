{...}: {
  flake.nixosModules.cli_multiplexer = {lib, ...}: {
    options.custom = {
      cli.multiplexer = lib.mkOption {
        type = lib.types.enum ["zellij" "tmux" "none"];
        default = "none";
        description = "Set the terminal multiplexer to be used.";
      };
    };
  };
}
