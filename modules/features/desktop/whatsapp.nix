{...}: {
  flake.nixosModules.desktop_whatsapp = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hyprland = config.custom.wm.wm == "hyprland";
    in {
      home.packages = [pkgs.karere];

      wayland.windowManager.hyprland.settings.window_rule = lib.mkIf hyprland [
        {
          match.title = "Karere";
          workspace = "4 silent";
        }
      ];
    };
  };
}
