{...}: {
  imports = [
    ./config.nix
    ./style.nix
  ];

  programs.waybar = {
    enable = true;
  };
}
