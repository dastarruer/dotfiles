{...}: {
  imports = [
    ./theme.nix
    ./config.nix
  ];

  programs.waybar.enable = true;
}
