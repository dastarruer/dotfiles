{pkgs, ...}: {
  # Enable fish shell
  programs.fish.enable = true;

  # Trust any user in the wheel group
  nix.settings.trusted-users = ["@wheel"];

  # Define the main user account
  users.users.dastarruer = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Ayush Pramanik";

    extraGroups = [
      "networkmanager" # Wifi control
      "wheel" # Sudo access
      "video" # Backlight access
      "input" # Access to input devices
      "docker" # Docker without root
    ];
  };
}
