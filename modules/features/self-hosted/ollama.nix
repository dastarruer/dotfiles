{...}: {
  flake.nixosModules.self-hosted_ollama = {...}: {
    services.ollama = {
      enable = true;
      
      syncModels = true;
      loadModels = [
        # Apparently best speed to accuracy ratio on systems with no gpu
        "qwen2.5-coder:7b"
      ];
    };
  };
}
