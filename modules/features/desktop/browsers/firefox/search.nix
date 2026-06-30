{...}: {
  flake.nixosModules.desktop_browser = {
    config,
    pkgs,
    lib,
    ...
  }: let
    browser = config.custom.desktop.browser.kind;
  in
    lib.mkIf (browser == "firefox"){
    home-manager.users.dastarruer = {
      programs.firefox.profiles.${config.custom.desktop.browser.profile}.search = {
        force = true;

        # Use brave because it's about as fast as google
        default = "brave";
        privateDefault = "brave";

        engines = {
          brave = {
            name = "Brave Search";
            urls = [
              {
                template = "https://search.brave.com/search?q={searchTerms}";
              }
            ];
            iconMapObj."16" = "https://brave.com/favicon.ico";
            definedAliases = [":b"];
          };

          nix-packages = {
            name = "Nix Packages";
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [":np"];
          };

          nixos-wiki = {
            name = "NixOS Wiki";
            urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
            iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
            definedAliases = [":nw"];
          };

          # Just in case...
          google.metaData.alias = ":g";
        };
      };
    };
  };
}
