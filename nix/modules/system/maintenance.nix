# Comes from https://www.youtube.com/watch?v=EI-6QX60WXc&t=915s
{
  inputs,
  pkgs,
  config,
  ...
}: {
  # Auto update
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      # Update inputs
      "--update-input"
      "nixpkgs"

      # Update lock file
      "--recreate-lock-file"

      # Commit after update
      "--commit-lock-file"
    ];

    # Run service once laptop has powered on and has internet access
    persistent = true;
    dates = "02:00";

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
