{
  pkgs,
  inputs,
  ...
}: {
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    libnotify

    # Git push fails if this is not a system package instead of a user one;
    gh
  ];

  # For nixd i think
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
