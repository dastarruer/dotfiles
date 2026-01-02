{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles.window-manager.batsignal.enable = lib.mkOption {
      type = lib.types.bool;
      default = config.dotfiles.window-manager.enable;
      description = "Enable batsignal, a script to send notifications on low battery.";
    };
  };

  config = lib.mkIf config.dotfiles.window-manager.batsignal.enable {
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
