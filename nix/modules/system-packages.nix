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

  # For nixd i think
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
