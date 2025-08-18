{pkgs, ...}: {
  # Most of these settings are from here: https://discourse.nixos.org/t/battery-life-still-isnt-great/41188
  imports = [
    ./auto-cpufreq.nix
    ./kernel-params.nix
    ./misc.nix
    ./conservation-mode.nix
  ];
}
