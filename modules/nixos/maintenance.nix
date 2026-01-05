# Comes from https://www.youtube.com/watch?v=EI-6QX60WXc&t=915s
{inputs, ...}: {
  # Auto update
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      # Update and commit lockfile
      "--recreate-lock-file"
      # "--commit-lock-file" # Requires git config, so is commented out

      # Reduce cpu load
      "--max-jobs"
      "1"
      "--cores"
      "1"

      "--impure"
    ];

    # Run service once laptop has powered on and has internet access
    persistent = true;

    dates = "Sat 10:00";
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
