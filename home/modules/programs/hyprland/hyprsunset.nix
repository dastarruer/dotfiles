{...}: {
  services.hyprsunset = {
    enable = true;

    extraArgs = [
      # Change temperature to a slightly warmer 5000K
      "-t"
      "5000"
    ];
  };
}
