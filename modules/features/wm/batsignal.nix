{...}: {
  flake.nixosModules.wm = {...}: {
    home-manager.users.dastarruer = {
      services.batsignal = {
        enable = true;

        extraArgs = [
          # Set warning level to 10% instead of default 15%
          "-w"
          "10"
        ];
      };
    };
  };
}
