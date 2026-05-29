{...}: {
  flake.nixosModules.desktop_obs = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hyprland = config.custom.wm.wm == "hyprland";
    in {
      programs.obs-studio.enable = true;

      # Create the save dir for obs
      systemd.user.tmpfiles.rules = [
        "d %h/Videos/screen-recordings - - - - -"
      ];

      # Let obs capture screen
      wayland.windowManager.hyprland.settings.permission = lib.mkIf hyprland [
        {
          binary = "${lib.getExe pkgs.obs-studio}";
          type = "screencopy";
          mode = "allow";
        }
      ];
    };
  };
}
