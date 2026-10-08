{...}: {
  flake.nixosModules.desktop_steam = {pkgs, ...}: let
    iniFormat = pkgs.formats.ini {};
  in {
    programs.steam.config = {
      # hitman
      apps."1659040" = {
        compatTool = "proton_11"; # having performance issues w latest ge proton
        systemd.enable = true;
        args = [
          "-skip_launcher"
        ];

        # Required for both smf and peacock so it's here instead
        files.game.place."Retail/mods/mods.ini".source = iniFormat.generate "mods" {
          sdk.crash_reporting = true;
          onlinetools = {};
          missioncompanion = {};
        };
      };
    };
  };
}
