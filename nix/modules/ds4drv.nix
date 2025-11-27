# See https://github.com/chrippa/ds4drv for all these settings
{pkgs, ...}: {
  environment.systemPackages = [pkgs.python313Packages.ds4drv];

  boot.kernelModules = ["uinput"];

  # Allow ds4drv to be run; at the user level
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0666"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0666"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", KERNELS=="0005:054C:05C4.*", MODE="0666"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", MODE="0666"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", KERNELS=="0005:054C:09CC.*", MODE="0666"
  '';
}
