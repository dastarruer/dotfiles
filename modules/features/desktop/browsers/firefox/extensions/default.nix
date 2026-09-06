{inputs, ...}: {
  flake.nixosModules.desktop_browser = {
    config,
    pkgs,
    lib,
    ...
  }: let
    profile = config.custom.desktop.browser.profile;
    firefoxPkgs = inputs.firefox-addons.packages.${pkgs.stdenv.system};
    browser = config.custom.desktop.browser.kind;
    hyprland = config.custom.wm.wm == "hyprland";
  in
    lib.mkIf (browser == "firefox") {
      home-manager.users.dastarruer = {
        programs.firefox.profiles."${profile}".extensions = {
          # Necessary to configure extension settings through hm
          force = true;

          packages = with firefoxPkgs; [
            ublock-origin
            i-dont-care-about-cookies
            privacy-badger
            link-cleaner
            bitwarden
          ];
        };

        # Float browser extension windows: https://wiki.hypr.land/configuring/code-snippets/#float-browsers-extension-windows
        # Only difference here is that floating windows are also pinned
        wayland.windowManager.hyprland.extraLuaFiles."float_extension_windows".content = lib.mkIf hyprland ''
          hl.on("window.open", function(w)
              if w.class ~= "firefox" then return end
              if w.initial_title ~= "Mozilla Firefox" then return end

              local ff_windows = hl.get_windows({ class = "firefox" })
              if #ff_windows <= 1 then return end

              hl.dispatch(hl.dsp.window.float({ action = "set", window = w }))

              local sub
              sub = hl.on("window.title", function(tw)
                  if tw.address ~= w.address then return end
                  if tw.title == ""
                      or tw.title == "Mozilla Firefox"
                      or tw.title == "about:blank"
                      or tw.title:match("^about:.*Mozilla Firefox$") then return end

                  sub:remove()

                  if tw.title:match("^Extension:") then
                      hl.dispatch(hl.dsp.window.resize({ x = 800, y = 600, window = tw }))
                      hl.dispatch(hl.dsp.window.center({ window = tw }))
                      hl.dispatch(hl.dsp.window.pin({ window = tw }))
                      hl.dispatch(hl.dsp.focus({ window = tw }))
                  else
                      hl.dispatch(hl.dsp.window.float({ action = "unset", window = tw }))
                  end
              end)
          end)
        '';
      };
    };
}
