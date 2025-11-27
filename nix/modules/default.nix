{...}: {
  imports = [
    ./desktops/hyprland
    ./boot
    ./self-hosted
    ./users
    ./services

    ./battery
    ./bluetooth.nix
    ./maintenance.nix
    ./networking.nix
    ./logind.nix
    ./system-packages.nix
    ./secrets.nix
    ./audio.nix
    ./gaming.nix
    ./earlyoom.nix
    ./ddcutil.nix
    ./ds4drv.nix
  ];
}
