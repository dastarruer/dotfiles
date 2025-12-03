{
  pkgs,
  inputs,
  ...
}: {
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    libnotify
    bat

    # Git push fails if this is not a system package instead of a user one;
    gh
  ];

  # Unable to open firewall port in home manager, so it is here instead
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
  # https://www.reddit.com/r/NixOS/comments/xz4m6m/how_to_use_kdeconnect_on_nixos/
  programs.kdeconnect = {
    enable = true;
  };
  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect
    ];
  };

  # Also unable to use this w home manager
  services.input-remapper = {
    enable = true;
  };

  # For nixd i think
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
