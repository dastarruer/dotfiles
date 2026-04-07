{...}: {
  flake.nixosModules.desktop_zathura = {
    config,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hyprland = config.wayland.windowManager.hyprland;
      fish = config.programs.fish;
    in {
      programs.zathura = {
        enable = true;

        options = {
          # Set dark mode by default
          recolor = true;

          # Fill window upon opening
          adjust_window = "best-fit";
          adjust_open = "best-fit";

          window-title-home-tilde = true;
          statusbar-basename = true;
          selection-clipboard = "clipboard";
          restore-session = true;
        };
      };

      programs.fish.shellAliases.zth = lib.mkIf fish.enable "zathura";

      # Set zathura as default pdf viewer
      xdg.mimeApps.defaultApplications."application/pdf" = ["org.pwmt.zathura.desktop"];

      wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
        windowrule = [
          "idle_inhibit focus, match:class org.pwmt.zathura"
        ];
      };
    };
  };
}
