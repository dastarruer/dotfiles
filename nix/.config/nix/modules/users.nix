{pkgs, ...}: {
  # Enable fish shell
  programs.fish.enable = true;

  # Define the main user account
  users.users.dastarruer = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Ayush Pramanik";
    extraGroups = ["networkmanager" "wheel"];
  };
}
