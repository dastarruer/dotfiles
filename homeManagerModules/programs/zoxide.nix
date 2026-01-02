{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.zoxide.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable zoxide.";
    };
  };

  config = lib.mkIf config.dotfiles.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = lib.mkIf config.dotfiles.shell.fish.enable true;
    };
  };
}
