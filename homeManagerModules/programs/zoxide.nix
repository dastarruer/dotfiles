{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.zoxide.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable zoxide.";
    };
  };

  config = lib.mkIf config.myPrograms.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = lib.mkIf config.myPrograms.shell.fish.enable true;
    };
  };
}
