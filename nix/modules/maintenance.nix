# Comes from https://www.youtube.com/watch?v=EI-6QX60WXc&t=915s
{inputs, ...}: {
  # Auto update
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      # Reduce cpu load
      "--max-jobs"
      "1"
      "--cores"
      "1"

      "--impure"
    ];

    # Run service once laptop has powered on and has internet access
    persistent = true;

    # Run after home manager update
    dates = "Sun 12:00";
  };

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
