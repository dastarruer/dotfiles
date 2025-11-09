# Comes from https://www.youtube.com/watch?v=EI-6QX60WXc&t=915s
{...}: {
  # Remove unused generations
  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "03:00";

    options = "--delete-older-than 7d";
  };

  # Periodically expire hm generations, idk if nix.gc makes this redundant though
  services.home-manager.autoExpire = {
    enable = true;
    frequency = "daily";
    store.cleanup = true;

    # Remove all generations older than 7 days
    timestamp = "-7 days";
  };
}
