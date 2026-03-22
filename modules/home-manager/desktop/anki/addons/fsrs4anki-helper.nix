{pkgs, ...}: {
  programs.anki.addons = [
    (pkgs.ankiAddons.fsrs4anki-helper.withConfig {
      # Config options here: https://github.com/open-spaced-repetition/fsrs4anki-helper/blob/8934a5d53caa68bf688e6b0964c36fb5a87970c0/config.md
      config = {
        auto_reschedule_after_sync = true;
        auto_disperse_after_sync = true;
        auto_disperse_after_reschedule = true;
        display_memory_state = true;
      };
    })
  ];
}
