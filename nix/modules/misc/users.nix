{pkgs, ...}: {
  # Enable fish shell
  programs.fish.enable = true;

  # Define the main user account
  users.users.dastarruer = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Ayush Pramanik";

    # video group lets me change brightness, wheel lets me use sudo, networkmanager lets me control wifi
    extraGroups = ["networkmanager" "wheel" "video"] "input";
  };
}
