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

  # For nixd i think
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
