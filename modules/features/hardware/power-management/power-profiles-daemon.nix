{...}: {
  flake.nixosModules.hardware = {
    config,
    lib,
    ...
  }: let
    daemon = config.custom.hardware.power-management;
  in
    lib.mkIf (daemon == "power-profiles-daemon") {
      services.power-profiles-daemon.enable = true;

      # Disable usb autosuspend for keyboards and mice
      services.udev.extraRules = ''
        ACTION=="add", SUBSYSTEM=="usb", ATTR{product}!="*Mouse", ATTR{product}!="*Keyboard", TEST=="power/control", ATTR{power/control}="auto"
      '';
    };
}
