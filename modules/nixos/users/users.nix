{
  config,
  pkgs,
  ...
}: {
  sops.secrets.sudo_password = {
    # https://github.com/Mic92/sops-nix#setting-a-users-password
    neededForUsers = true;
  };

  # Enable fish shell
  programs.fish.enable = true;

  # Trust any user in the wheel group
  nix.settings.trusted-users = ["@wheel"];

  # Define the main user account
  users.users.dastarruer = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Ayush Pramanik";
    hashedPasswordFile = config.sops.secrets.sudo_password.path;

    extraGroups = [
      "networkmanager" # Wifi control
      "wheel" # Sudo access
      "video" # Backlight access
      "input" # Access to input devices
      "docker" # Docker without root
    ];
  };
}
