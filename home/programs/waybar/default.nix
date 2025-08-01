{...}: {
  # Waybar comes from here: https://github.com/bibjaw99/workstation/tree/master/.config/waybar_block
  imports = [
    ./config.nix
    ./style.nix
  ];

  programs.waybar = {
    enable = true;
  };
}
