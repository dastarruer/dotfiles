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

  # Also unable to use this w home manager
  services.input-remapper = {
    enable = true;
  };

  # For nixd i think
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
