{...}: {
  flake.nixosModules.desktop_firefox = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hyprland = config.programs.hyprland;
  in {
    options = {
      home-manager.desktop.firefox = {
        profile = lib.mkOption {
          type = lib.types.str;
          default = "default";
          description = "Name of the default profile.";
        };
        deckFixes = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Apply Steam Deck specific Firefox settings.";
        };
      };
    };

    config.home-manager.users.dastarruer = {
      # Necessary for gdocs to render fonts properly
      home.packages = [pkgs.corefonts];

      programs.firefox = {
        enable = true;
        package = pkgs.firefox-bin;
      };

      # Windowrules for picture-in-picture
      wayland.windowManager.hyprland.settings = lib.mkIf hyprland.enable {
        windowrule = [
          "float on, match:title Picture-in-Picture"
          "move 1492 839, match:title Picture-in-Picture"
          "size 427 240, match:title Picture-in-Picture"
          "pin on, match:title Picture-in-Picture"
        ];
      };
    };
  };
}
