# Comes from https://www.youtube.com/watch?v=EI-6QX60WXc&t=915s
{...}: {
  # Auto update
  # system.autoUpgrade = {
  #   enable = true;
  #   flake = inputs.self.outPath;
  #   flags = [
  #     # Reduce cpu load
  #     "--max-jobs"
  #     "4"
  #     "--cores"
  #     "4"

  #     # Update nixpkgs
  #     "--update-input"
  #     "nixpkgs"

  #     # Update flatpaks
  #     "--update-input"
  #     "flatpaks"

  #     # Update hyprland
  #     "--update-input"
  #     "hyprland"

  #     # Impure mode
  #     "--impure"
  #   ];

  #   # Run service once laptop has powered on and has internet access
  #   persistent = true;

  #   # Run after school
  #   dates = "15:00";

  #   # allow rebooting after every upgrade (just in case!)
  #   # allowReboot = true;

  #   # Nvm auto reboot sucks
  #   allowReboot = false;
  # };

  # Remove unused generations
  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "03:00";

    options = "--delete-older-than 7d";
  };

  # Remove unused packages
  nix.optimise = {
    automatic = true;
    persistent = true;
    dates = ["04:00"];
  };
}
