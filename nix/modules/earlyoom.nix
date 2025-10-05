# earlyoom will kill processes that are taking up the most ram when ram usage is high
# https://github.com/rfjakob/earlyoom
{...}: {
  services.earlyoom = {
    enable = true;
    enableNotifications = true;

    # If 5% of memory is left, start killing processes
    freeMemThreshold = 5;
  };
}
