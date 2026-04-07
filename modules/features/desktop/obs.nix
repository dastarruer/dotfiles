{...}: {
  flake.nixosModules.desktop_obs = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hyprland = config.wayland.windowManager.hyprland;
    in {
      programs.obs-studio.enable = true;

      # Create the save dir for obs
      systemd.user.tmpfiles.rules = [
        "d %h/Videos/screen-recordings - - - - -"
      ];

      # Let obs capture screen
      wayland.windowManager.hyprland.settings.permission = lib.mkIf hyprland.enable [
        "${pkgs.obs-studio}/bin/obs, screencopy, allow"
      ];
    };
  };
}
