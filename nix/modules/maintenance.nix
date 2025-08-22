# Comes from https://www.youtube.com/watch?v=EI-6QX60WXc&t=915s
{inputs, ...}: {
  # Auto update
  system.autoUpgrade = {
    enable = false;
    flake = inputs.self.outPath;
    flags = [
      # Reduce cpu load
      "--max-jobs"
      "4"
      "--cores"
      "4"

      # Update nixpkgs
      "--update-input"
      "nixpkgs"

      # Update flatpaks
      "--update-input"
      "flatpaks"

      # Impure mode
      "--impure"
    ];

    # Run service once laptop has powered on and has internet access
    persistent = true;

    # Run after school
    dates = "15:00";

    # allow rebooting after every upgrade (just in case!)
    # allowReboot = true;

    # Nvm auto reboot sucks
    allowReboot = false;
  };

  # Remove unused generations
  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "03:00";

    # Very rarely do i rollback so here ig... will speed up boot too
    options = "--delete-older-than 2d";
  };

  # Remove unused packages
  nix.optimise = {
    automatic = true;
    persistent = true;
    dates = ["04:00"];
  };
}
