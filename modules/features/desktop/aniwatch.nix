{...}: {
  flake.nixosModules.desktop_aniwatch = {pkgs, ...}: {
    home-manager.users.dastarruer = {
      programs.firefoxpwa = {
        enable = true;

        # Note that each PWA needs a different profile with a unique ULID
        # Run `nix-shell -p ulid --run "ulid"` to get a valid ULID
        profiles."01KEN6AHN9T22VYKX9RERBHBKN".sites."01KEN6APJP25MQKMWJCPP5XHBJ" = {
          name = "AniWatch";
          url = "https://aniwatchtv.to/";
          manifestUrl = "https://aniwatchtv.to/manifest.json";

          desktopEntry = {
            enable = true;
            icon = pkgs.fetchurl {
              url = "https://aniwatchtv.to/images/android-chrome-512x512.png";
              sha256 = "sha256-3cs2H43h3JpkYeEkGWoXCg9aPDtaRT/R9Qzx64RzWZ0=";
            };
          };
        };
      };
    };
  };
}
