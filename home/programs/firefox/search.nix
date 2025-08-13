{pkgs, ...}: {
  programs.firefox.profiles.default.search = {
    default = "brave";
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

      google.metaData.alias = ":g";
    };
  };
}
