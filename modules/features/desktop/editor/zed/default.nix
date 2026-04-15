{...}: {
  flake.nixosModules.desktop_editor = {
    config,
    pkgs,
    lib,
    ...
  }: let
    editor = config.custom.editor;
    fish = config.programs.fish;
    gitCommand = "${lib.getExe pkgs.zed-editor} --wait";
  in {
    home-manager.users.dastarruer = lib.mkIf (editor == "zed") {
      programs.gh.settings.editor = gitCommand;
      programs.git.settings.core.editor = gitCommand;

      programs.zed-editor = {
        enable = true;

        extensions = [
          "svelte"
          "toml"
          "nix"
          "git-firefly"
          "dockerfile"
          "docker-compose"
        ];

        userSettings = {
          telemetry = {
            diagnostics = false;
            metrics = false;
          };

          vim_mode = false;

          file_types = {
            "Env" = [".env*"];
            "INI" = ["*.cfg" "*.cnf" "*.conf" "*.config"];
          };

          # Override stylix code font size
          buffer_font_size = lib.mkForce 15;

          # Layout
          agent = {
            dock = "right";
          };
          notification_panel = {
            dock = "right";
          };
          git_panel = {
            dock = "right";
          };
          outline_panel = {
            dock = "right";
          };
          project_panel = {
            dock = "right";
          };
        };
      };

      programs.fish.shellAliases.zed = lib.mkIf fish.enable "${lib.getExe pkgs.zed-editor}";
    };
  };
}
