{...}: {
  flake.nixosModules.desktop_vscode = {
    config,
    pkgs,
    lib,
    ...
  }: {
    options.custom = {
      desktop.vscode = {
        profile = lib.mkOption {
          type = lib.types.str;
          default = "default";
          description = "The vscode profile to use.";
        };
      };
    };

    config.home-manager.users.dastarruer = let
      profile = config.custom.desktop.vscode.profile;
      package = config.custom.desktop.vscode.profile;
      fish = config.programs.fish;
    in
      lib.mkIf config.custom.desktop.vscode.enable {
        programs.vscode = {
          enable = true;
          # Use vscode fhs so lldb works: https://www.reddit.com/r/NixOS/comments/1e724mx/how_can_i_debug_rust_with_vscode_and/
          package = pkgs.vscode.fhs;

          # Only way that extensions actually get installed if home-manager is a nixos module for some reason
          # mutableExtensionsDir = false;
          mutableExtensionsDir = true;

          # Privacy settings (https://paulsorensen.io/github-copilot-vscode-privacy/)
          # Only set if package is not vscodium
          profiles.${profile}.userSettings = lib.optionalAttrs (!lib.hasInfix "vscodium" (lib.getName package)) {
            "telemetry.telemetryLevel" = "off";
            "telemetry.feedback.enabled" = false;
            "workbench.enableExperiments" = false;
            "extensions.autoUpdate" = false;
            "extensions.ignoreRecommendations" = true;
            "files.associations" = {
              ".env*" = "dotenv";
              "*.cfg" = "ini";
              "*.cnf" = "ini";
              "*.conf" = "ini";
              "*.config" = "ini";
            };
            "github.copilot.enable" = {
              "*" = true;
              "dotenv" = false;
              "ini" = false;
              "json" = false;
              "yaml" = false;
            };
            "github.copilot.advanced" = {
              "webSearch" = false;
            };
            "omnisharp.enableTelemetry" = false;
            "powershell.telemetry.enable" = false;
            "pylance.telemetry" = false;
            "python.telemetry.enable" = false;
            "debugpy.telemetry.enable" = false;
          };
        };

        # Run vscode under wayland
        home.sessionVariables.NIXOS_OZONE_WL = "1";

        programs.fish.shellAliases.code = lib.mkIf fish.enable "${lib.getExe config.programs.vscode.package}";
      };
  };
}
