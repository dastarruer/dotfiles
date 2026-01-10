{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./extensions.nix
    ./settings
    ./languages
  ];

  options = {
    home-manager.desktop.vscode = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.home-manager.desktop.enable;
        description = "Enable vscode.";
      };
      profile = lib.mkOption {
        type = lib.types.str;
        default = "default";
        description = "The vscode profile to use.";
      };
    };
  };

  config = let
    profile = config.home-manager.desktop.vscode.profile;
  in
    lib.mkIf config.home-manager.desktop.vscode.enable {
      programs.vscode = {
        enable = true;
        # Use vscode fhs so lldb works: https://www.reddit.com/r/NixOS/comments/1e724mx/how_can_i_debug_rust_with_vscode_and/
        # use vscode because devcontainers only works w regular vscode
        package = pkgs.vscode.fhs;

        # Privacy settings (https://paulsorensen.io/github-copilot-vscode-privacy/)
        profiles.${profile}.userSettings = {
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
    };
}
