{pkgs, ...}: {
  # Suppress warning (https://nixos.org/manual/nixos/stable/options.html#opt-system.stateVersion)
  system.stateVersion = "25.05";

  # Enable ssh
  services.openssh.enable = true;
  services.flatpak.enable = true;
  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  # Brightness
  hardware.brillo.enable = true;

  programs.steam = {
    enable = true;
    extest.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  nix.settings = {
    max-jobs = "auto";

    # Enable flakes
    experimental-features = ["nix-command" "flakes"];

    extra-substituters = [
      # Use nix-community binary cache to avoid building from source as much as possible
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
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

    # For RAM intensive applications that may not use all the ram it allocates, promise more ram than is available (only up to a certain point. Otherwise, the process may be killed by earlyoom).
    # https://medium.com/@charles.vissol/optimize-your-linux-69c70320d852
    # "vm.overcommit-memory" = 2;
    "vm.overcommit-memory" = 0;

    # write dirty pages to disk once 5% of ram holds dirty pages
    # https://medium.com/@charles.vissol/optimize-your-linux-69c70320d852
    "vm.dirty_background_ratio" = 5;
  };

  # Used to sync system clock
  # Use these settings so that boot does not get slowed down
  services.timesyncd = {
    enable = true;
    servers = ["time.cloudflare.com" "pool.ntp.org"];
  };

  # Reduce blurry fonts: https://www.reddit.com/r/xfce/comments/vfe7uy/comment/icyffxj/?force-legacy-sct=1
  environment.etc."environment".text = ''FREETYPE_PROPERTIES="truetype:interpreter-version=35"'';
}
