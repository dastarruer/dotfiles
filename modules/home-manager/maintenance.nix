# Comes from https://www.youtube.com/watch?v=EI-6QX60WXc&t=915s
{config, ...}: {
  services.home-manager.autoUpgrade = {
    enable = true;
    frequency = "Sat 12:00";
    useFlake = true;
    # inputs.self.outDir will throw an error when used with useFlake for whatever reason.
    flakeDir = "${config.home.homeDirectory}/.dotfiles";
  };

  # Remove unused generations
  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "03:00";

    options = "--delete-older-than 7d";
  };

  # Remove old home manager generations
  services.home-manager.autoExpire = {
    enable = true;
    frequency = "daily";
    store.cleanup = true;

    # Remove all generations older than 7 days
    timestamp = "-7 days";
  };
}
