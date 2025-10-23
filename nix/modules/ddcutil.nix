# ddcutil lets me control the backlight of my external monitor
{
  pkgs,
  config,
  ...
}: {
  # This is so brillo can control the monitor. but it's slow, so I'll do something else (https://wiki.nixos.org/wiki/Backlight#Via_ddcci-driver)
  # NOTE: This requires the 6.17 kernel
  boot.extraModulePackages = with config.boot.kernelPackages; [ddcci-driver];

  boot.kernelModules = ["ddcci-backlight"];

  services.udev.extraRules = let
    bash = "${pkgs.bash}/bin/bash";
    ddcciDev = "AMDGPU DM i2c hw bus 1";
    ddcciNode = "/sys/bus/i2c/devices/i2c-7/new_device";
  in ''
      SUBSYSTEM=="i2c", ACTION=="add", ATTR{name}=="${ddcciDev}", RUN+="${bash} -c 'sleep 30; printf ddcci\ 0x37 > ${ddcciNode}'"
    # '';

  # https://wiki.nixos.org/wiki/Backlight#Via_ddcutil
  # this way i have to manually use the ddcutil command but it's faster so yk
  # hardware.i2c.enable = true;
  # environment.systemPackages = [pkgs.ddcutil];

  # # Give user access to monitor brightness control
  # users.users.dastarruer.extraGroups = ["ic2"];
}
