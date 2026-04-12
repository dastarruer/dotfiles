{...}: {
  flake.nixosModules.core = {
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
        "wheel" # Sudo access
        "input" # Access to input devices
      ];
    };

    # Automatically set timezone: https://www.reddit.com/r/NixOS/comments/1411gjs/dynamically_set_the_timezone/
    services.automatic-timezoned.enable = true;

    # Used to sync system clock
    # Can be wildly inaccurate depending on physical loaction
    # services.timesyncd = {
    #   enable = true;
    #   servers = ["time.cloudflare.com" "pool.ntp.org"];
    # };
    services.tzupdate.enable = true;

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    # Set the keyboard layout for the TTY
    console.keyMap = "us";
  };
}
