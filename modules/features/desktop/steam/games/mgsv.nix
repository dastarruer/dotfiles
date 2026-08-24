# Metal Gear Solid V
{...}: {
  flake.nixosModules.desktop_steam = {...}: {
    # If using latest version then 'Failed to load Steam API' error pops up instead. This seems to run the game just fine
    programs.steam.config.apps."287700".compatTool = "proton_7";
  };
}
