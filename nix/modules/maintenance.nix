# Comes from https://www.youtube.com/watch?v=EI-6QX60WXc&t=915s
{inputs, ...}: {
  # Auto update
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "--print-build-logs"

      # Update the lock file manually because i dont know what im doing
      "&&"
      "cd"
      "/home/dastarruer/.dotfiles"
      "nix flake update"
      "/home/dastarruer/bin/commit_dotfiles.sh"
      "\"Update lock file\""
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";

    # allow rebooting after every upgrade (just in case!)
    allowReboot = true;
  };

  # Remove unused generations
  nix.gc = {
    automatic = true;
    dates = "00:01";
    options = "--delete-older-than 10d";
  };

  # Remove unused packages
  nix.optimise = {
    automatic = true;
    dates = ["05:00"];
  };
}
