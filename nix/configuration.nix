{inputs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Import all the other files
    ./modules/default.nix

    # Import home manager
    inputs.home-manager.nixosModules.home-manager
  ];

  # Suppress warning (https://nixos.org/manual/nixos/stable/options.html#opt-system.stateVersion)
  system.stateVersion = "25.05";

  # Enable ssh
  services.openssh.enable = true;

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Better battery life
  services.auto-cpufreq.enable = true;

  # Brightness
  hardware.brillo.enable = true;

  # Next section comes from https://www.youtube.com/watch?v=EI-6QX60WXc&t=915s
  # Auto update
  system.autoUpgrade = {
    enable = true;
    dates = "02:00";
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

  # Home manager
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      dastarruer = import ../home.nix;
    };
  };
}
