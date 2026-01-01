{
  config,
  lib,
  ...
}: {
  options = {
    myPrograms.batsignal.enable = lib.mkEnableOption "Enable batsignal, a script to send notifications on low battery.";
  };

  config = lib.mkIf config.myPrograms.batsignal.enable {
    services.batsignal = {
      enable = true;
      extraArgs = [
        # Set warning level to 10% instead of default 15%
        "-w"
        "10"
      ];
    };
  };
}
