# Metal Gear Solid V
{...}: {
  flake.nixosModules.desktop_steam = {...}: {
    programs.steam.config = {
      apps.mgsv = {
        id = 287700;
        compatTool = "proton_7"; # If using latest version then 'Failed to load Steam API' error pops up instead. This seems to run the game just fine
        launchOptions.args = [
          "gamemoderun"
        ];
      };
    };
  };
}
