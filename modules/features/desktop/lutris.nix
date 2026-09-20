{self, ...}: {
  flake.nixosModules.desktop_lutris = {
    config,
    pkgs,
    lib,
    ...
  }: let
    hmConfig = config.home-manager.users.dastarruer;
    ludusavi = hmConfig.services.ludusavi;
  in {
    imports = [
      self.nixosModules.desktop_gaming
    ];

    home-manager.users.dastarruer = {
      programs.lutris = {
        enable = true;
        steamPackage = config.programs.steam.package;
        defaultWinePackage = pkgs.proton-ge-bin;
        protonPackages = with pkgs; [
          proton-ge-bin
        ];
        extraPackages = with pkgs; [
          gamescope
          gamemode
        ];

        runners.wine.settings = {
          system = {
            gamescope = "true";
            gamescope_flags = lib.concatStringsSep " " [];
          };
          runner = {
            # Enable controller support
            autoconf_joypad = true;
          };
        };
      };

      # Add lutris to ludusavi
      services.ludusavi.settings = lib.mkIf ludusavi.enable {
        roots = [
          {
            store = "lutris";
            path = "${config.home-manager.users.dastarruer.home.homeDirectory}/.config/lutris";
            database = "${config.home-manager.users.dastarruer.home.homeDirectory}/.local/share/lutris/pgs.db";
          }
        ];
      };
    };
  };
}
