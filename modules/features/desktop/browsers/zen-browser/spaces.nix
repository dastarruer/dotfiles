{...}: {
  flake.nixosModules.desktop_browser = {
    config,
    lib,
    ...
  }: let
    browser = config.custom.desktop.browser.kind;
    profile = config.custom.desktop.browser.profile;
    containers = config.home-manager.users.dastarruer.programs.zen-browser.profiles."${profile}".containers;
  in
    lib.mkIf (browser == "zen-browser") {
      home-manager.users.dastarruer = {
        programs.zen-browser.profiles."${profile}" = {
          spacesForce = true;

          # Space ids are generated using `uuidgen` command
          spaces = {
            other = {
              id = "5ee0f38d-6555-46b0-af24-982a3301a87e";
              position = 1000;
              icon = "";
              container = containers.personal.id;
            };
            nix = {
              id = "d54644a8-e432-4f90-ae91-b92059030a92";
              position = 2000;
              icon = "";
              container = containers.personal.id;
            };
            math = {
              id = "5d0c2ac4-a60e-4720-880e-0d3b9523cbf7";
              position = 3000;
              icon = "";
              container = containers.school.id;
            };
            english = {
              id = "e5d01710-345d-49d9-90b1-b3520aeaf588";
              position = 4000;
              icon = "";
              container = containers.school.id;
            };
            chem = {
              id = "859bb58f-797a-4ef0-b9a7-0c1ce2a3e6b6";
              position = 5000;
              icon = "";
              container = containers.school.id;
            };
            spanish = {
              id = "563005f3-2a53-4fc9-909e-fe7f5972c57c";
              position = 6000;
              icon = "";
              container = containers.school.id;
            };
            physics = {
              id = "67b5ca5b-2df2-41b6-8f02-81c2378d3048";
              position = 7000;
              icon = "";
              container = containers.school.id;
            };
          };
        };
      };
    };
}
