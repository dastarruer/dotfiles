{...}: {
  imports = [
    ./conservation-mode.nix
    ./low-battery.nix
    ./reload-udev.nix
    # ./auto-upgrade.nix
  ];
}
