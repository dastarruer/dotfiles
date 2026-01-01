{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.zoxide.enable = lib.mkEnableOption "Enable zoxide.";
  };

  config = lib.mkIf config.myPrograms.zoxide.enable {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
