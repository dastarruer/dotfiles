{...}: {
  flake.nixosModules.desktop_kdeconnect = {
    config,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;
    hyprland = hmConfig.wayland.windowManager.hyprland;
  in {
    # https://www.reddit.com/r/NixOS/comments/xz4m6m/how_to_use_kdeconnect_on_nixos/
    programs.kdeconnect = {
      enable = true;
    };
    networking.firewall = {
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        } # KDE Connect
      ];
    };

    home-manager.users.dastarruer = {
      wayland.windowManager.hyprland.settings =
        lib.mkIf hyprland.enable {
          windowrule = [
            # Float the 'Receiving file' popup that occurs when transferring a large file
            "float on, match:title ^(Receiving file)(.*)$"
          ];
        };
    };
  };
}
