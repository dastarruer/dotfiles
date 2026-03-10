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
    ./audio.nix
    ./gaming.nix
    ./earlyoom.nix
    ./backlight.nix
    ./virtualization.nix
    ./secrets.nix
    ./fontconfig.nix
  ];
}
