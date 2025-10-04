{inputs, ...}: {
  imports = [
    /etc/nixos/hardware-configuration.nix

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

  # Enable docker
  # By default this requires root, but I added my user to the docker group which doesn't need root
  virtualisation.docker.enable = true;

  # Allow fonts to work with flatpak (https://wiki.nixos.org/wiki/Fonts#Flatpak_applications_can't_find_system_fonts)
  # If any issues arise, read through the wiki
  # Note that home-manager flatpak configuration is in flatpak.nix
  fonts.fontDir.enable = true;

  # Run this command in order to give flatpak acces to system fonts (https://wiki.nixos.org/wiki/Fonts#Solution_1:_Copy_fonts_to_$HOME/.local/share/fonts)
  # Note that fonts.fontDir.enable = true is required for this, which is already declared in configuration.nix
  # TODO: make this work, it hangs nixos-rebuild
  # system.activationScripts.copyFonts.text = ''
  #   mkdir -p "/home/dastarruer/.local/share/fonts"
  #   cp -L /run/current-system/sw/share/X11/fonts/* "/home/dastarruer/.local/share/fonts/" || true
  # '';

  # Gives extra ram basically
  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "zstd";
  };

  boot.kernel.sysctl = {
    # Only use swap when completely necessary
    "vm.swappiness" = 20;
  };

  # Used to sync system clock
  # Use these settings so that boot does not get slowed down
  services.timesyncd = {
    enable = true;
    servers = ["time.cloudflare.com" "pool.ntp.org"];
  };
}
