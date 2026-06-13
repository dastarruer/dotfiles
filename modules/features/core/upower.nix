{...}: {
  flake.nixosModules.core = {...}: {
    services.upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 10;

      # The battery percentage where the system executes an emergency action
      percentageAction = 5;
      allowRiskyCriticalPowerAction = true;
      criticalPowerAction = "Suspend";
    };
  };
}
