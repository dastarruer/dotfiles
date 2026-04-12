{...}: {
  flake.nixosModules.wm = {...}: {
    home-manager.users.dastarruer = {
      services.hyprsunset = {
        enable = true;

        extraArgs = [
          # Change temperature to a slightly warmer 5500K
          "-t"
          "5500"
        ];
      };
    };
  };
}
