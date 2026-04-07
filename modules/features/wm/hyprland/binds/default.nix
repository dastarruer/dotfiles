{...}: {
  flake.nixosModules.wm = {pkgs, ...}: {
    home-manager.users.dastarruer = {
      wayland.windowManager.hyprland.settings = {
        "bindm" = [
          "SUPER, mouse:272, movewindow"
        ];

        bind = [
          "SUPER+SHIFT, K, exec, ${pkgs.hyprland}/bin/hyprctl kill"
        ];
      };
    };
  };
}
