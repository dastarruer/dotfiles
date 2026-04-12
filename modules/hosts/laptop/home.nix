{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.laptopHome = {
    config,
    lib,
    ...
  }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager.users.dastarruer = {
      systemd.user.enable = true;
      nixpkgs.config.allowUnfree = true;

      # Set up user
      home = {
        # Set username and home directory
        username = "dastarruer";
        homeDirectory = lib.mkForce "/home/dastarruer";

        # No clue what this does
        stateVersion = "25.11";
      };

      systemd.user.tmpfiles.rules = [
        # Create the Downloads dir, deleting files older than 5 days
        "d %h/Downloads - - - 5d -"

        # Create the Trash dir, deleting files older than 30 days
        "d %h/.local/share/Trash/files - - - 30d -"
      ];

      services.polkit-gnome.enable = true;
    };
  };
}
