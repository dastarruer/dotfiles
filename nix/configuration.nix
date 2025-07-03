{
  inputs,
  pkgs,
  ...
}: {
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

  # Home manager
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      dastarruer = import ../home.nix;
    };
  };
}
