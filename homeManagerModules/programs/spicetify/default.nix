# HELLO FUTURE ME basically spicetify on nix will not work if you also install spotify in packages.nix so yeah
# https://gerg-l.github.io/spicetify-nix/usage.html
{spicePkgs, ...}: {
  imports = [
    ./extensions.nix
    ./snippets.nix
    ./theme.nix
  ];

  programs.spicetify = {
    enable = true;

    # Custom apps
    enabledCustomApps = with spicePkgs.apps; [
      marketplace
    ];

    # Chromium devtools
    alwaysEnableDevTools = true;

    wayland = true;
  };

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "float, class:^(spotify)$"
      "move 81 146, class:^(spotify)$"
      "size 1068 670, class:^(spotify)$"
    ];

    windowrulev2 = [
      "workspace 5 silent,class:^(spotify)$"
    ];
  };
}
