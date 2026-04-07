{...}: {
  flake.nixosModules.wm = {
    config,
    pkgs,
    lib,
    ...
  }: {
    home-manager.users.dastarruer = let
      hypridle = config.services.hypridle;
      locker = config.custom.wm.locker;
    in {
      programs.swaylock = lib.mkIf (locker == "swaylock") {
        enable = true;
        settings = {
          ignore-empty-password = true;

          image = "${config.home.homeDirectory}/Pictures/wallpaper";
          indicator-x-position = 100;
          indicator-y-position = 950;
        };
      };

      services.hypridle.settings.general.lock_cmd = lib.mkIf hypridle.enable "pidof swaylock || ${pkgs.swaylock}/bin/swaylock";
    };
  };
}
