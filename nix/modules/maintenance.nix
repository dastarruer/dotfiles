# Comes from https://www.youtube.com/watch?v=EI-6QX60WXc&t=915s
{inputs, ...}: {
  # Auto update
  system.autoUpgrade = {
    enable = true;

    # Tell autoUpgrade to update this flake
    flake = inputs.self.outPath;
    flags = [
      "-L" # print build logs
    ];

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
