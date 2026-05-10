{...}: {
  flake.nixosModules.desktop_editor = {
    config,
    pkgs,
    lib,
    ...
  }: let
    editor = config.custom.desktop.editor;
    fish = config.programs.fish;
    gitCommand = "${lib.getExe pkgs.zed-editor} --wait";

    hmConfig = config.home-manager.users.dastarruer;
    geminiKeyPath = hmConfig.sops.secrets.gemini_api_key.path;
  in {
    # Allow zed-editor to install its own language servers
    # zed-fhs is not enough on its own; this has to be enabled as well
    programs.nix-ld.enable = true;

    home-manager.users.dastarruer = lib.mkIf (editor == "zed") {
      programs.gh.settings.editor = gitCommand;
      programs.git.settings.core.editor = gitCommand;

      sops.secrets = {
        gemini_api_key = {};
      };

      # Set api key for gemini: https://zed.dev/docs/ai/llm-providers#google-ai
      home.sessionVariables."GEMINI_API_KEY" =
        if (builtins.pathExists geminiKeyPath)
        then (builtins.readFile geminiKeyPath)
        else "";

      programs.zed-editor = {
        enable = true;
        # Allow zed-editor to install its own language servers
        # Otherwise, i will go insane, because idk if i can point zed to a specific lsp binary
        package = pkgs.zed-editor-fhs;

        extensions = [
          "html"
          "markdownlint"
          "svelte"
          "toml"
          "nix"
          "git-firefly"
          "dockerfile"
          "docker-compose"
          "comment" # highlight todo comments
        ];

        userKeymaps = [
          {
            bindings."ctrl-`" = "terminal_panel::ToggleFocus";
          }
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

          scrollbar.diagnostics = "warning"; # Only show warnings on the scrollbar

          # Enable zed's version of errorlens
          diagnostics.inline = {
            enabled = true;
            max_severity = "hint";
          };

          # If provider is not specified, zed will keep trying to do edit predictions which slows down the editor massively
          edit_predictions.provider = "none";

          file_scan_exclusions = [
            "**/.git"
            "**/.svn"
            "**/.hg"
            "**/.jj"
            "**/CVS"
            "**/.DS_Store"
            "**/Thumbs.db"
            "**/.classpath"
            "**/.settings"
            "**/.local"
            "**/.direnv"
            "**/.svelte-kit"
            "**/node_modules"
          ];

          agent = {
            default_profile = "ask";
            default_model = {
              provider = "google";
              model = "gemini-3.1-pro-review";
              enable_thinking = true;
            };
            favorite_models = [];
            model_parameters = [];
          };

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
