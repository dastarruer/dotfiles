{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.cli.zoxide.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable zoxide.";
    };
  };

  config = lib.mkIf config.dotfiles.cli.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = lib.mkIf config.dotfiles.cli.shell.fish.enable true;
    };
  };
}
