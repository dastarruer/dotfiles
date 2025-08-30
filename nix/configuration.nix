{inputs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Import all the other files
    ./modules/default.nix

    # Import home manager
    inputs.home-manager.nixosModules.home-manager

    # Microcode updates (check flake for url)
    inputs.ucodenix.nixosModules.default
  ];

  # Suppress warning (https://nixos.org/manual/nixos/stable/options.html#opt-system.stateVersion)
  system.stateVersion = "25.05";

  # Enable ssh
  services.openssh.enable = true;

  # Enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Brightness
  hardware.brillo.enable = true;

  nix.settings = {
    # Use all possible cpu resources for rebuilds
    max-jobs = "auto";
    cores = 0;
  };

  # Microcode updates (might as well yk)
  services.ucodenix = {
    enable = true;

    # Specify cpu id to process only my cpu's thingamabob
    cpuModelId = "00A50F00";
  };

  # Allow fonts to work with flatpak (https://wiki.nixos.org/wiki/Fonts#Flatpak_applications_can't_find_system_fonts)
  # If any issues arise, read through the wiki
  # Note that home-manager flatpak configuration is in flatpak.nix
  fonts.fontDir.enable = true;

  # Home manager
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      dastarruer = import ../home.nix;
    };
  };
}
