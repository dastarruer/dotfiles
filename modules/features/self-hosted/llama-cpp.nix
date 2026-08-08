# https://www.youtube.com/watch?v=ydFikMBJG1g&t=4569s
{...}: {
  flake.nixosModules.self-hosted_llama-cpp = {pkgs, ...}: let
    iniFormat = pkgs.formats.ini {};
    modelsConfig = iniFormat.generate "models.ini" {
      "gemma-4-E2B".hf = "unsloth/gemma-4-E2B-it-GGUF";
      "tinyllama-1.1b".hf = "TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF";
      "qwen3-0.6b".hf = "Qwen/Qwen3-0.6B-GGUF";
    };
  in {
    services.llama-cpp = {
      enable = true;
      openFirewall = true;

      settings = {
        models-preset = modelsConfig;
        models-max = 1; # no one needs more than one model loaded
        sleep-idle-seconds = 900; # 15 mins
        parallel = 1;
        port = 8081; # webdav already takes port 8080
        n-gpu-layers = -1; # don't have a gpu so set this to -1
      };
    };
  };
}
