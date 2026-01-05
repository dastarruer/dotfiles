{...}: {
  imports = [
    ./workspaces.nix
    ./windows.nix
    ./media.nix
    ./scripts.nix
    ./screenshots.nix
  ];

  wayland.windowManager.hyprland.settings = {
    "bindm" = [
      "SUPER, mouse:272, movewindow"
    ];
  };
}
