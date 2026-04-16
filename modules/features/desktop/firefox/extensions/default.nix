{inputs, ...}: {
  flake.nixosModules.desktop_firefox = {
    config,
    pkgs,
    ...
  }: {
    home-manager.users.dastarruer = {
      programs.firefox.profiles."${config.custom.desktop.firefox.profile}".extensions = {
        # Necessary to configure extension settings through hm
        force = true;

        packages = with inputs.firefox-addons.packages.${pkgs.stdenv.system}; [
          ublock-origin
          i-dont-care-about-cookies
          privacy-badger
          link-cleaner
          bitwarden
        ];
      };
    };
  };
}
