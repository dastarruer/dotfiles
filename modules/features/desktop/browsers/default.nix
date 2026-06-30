{...}: {
  flake.nixosModules.desktop_browser = {lib, ...}: {
    options.custom = {
      desktop.browser = {
        kind = lib.mkOption {
          type = lib.types.enum ["firefox" "zen-browser" "none"];
          default = "none";
          description = "Set the browser to be used.";
        };
        profile = lib.mkOption {
          type = lib.types.str;
          default = "default";
          description = "Name of the default profile.";
        };
      };
    };
  };
}
