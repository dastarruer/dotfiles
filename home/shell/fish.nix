{...}: {
  # Enable fish shell
  programs.fish = {
    enable = true;

    # Remove greeting
    shellInit = ''
      set -g fish_greeting ""
      fastfetch

      # Pywal colors
      if test -e ~/.cache/wal/colors.fish
          source ~/.cache/wal/colors.fish
      end
    '';

    # Set aliases
    shellAliases = {
      code = "codium";
      chx = "chmod +x";
      pr = "python3 main.py";
      ps = "sudo auto-cpufreq --force powersave";
      p = "sudo auto-cpufreq --force performance";
      stats = "sudo auto-cpufreq --stats";
      pls = "sudo";
      save = "save_workspace_layouts.sh";
      restore = "restore_workspace_layouts.sh";
      stast = "sudo auto-cpufreq --stats";
      df = "cd ~/.dotfiles";
      grep = "grep -i";
      timeshift = "sudo timeshift";
      pipes = "pipes -p 10";
      cmatrix = "cmatrix -u 3 -C magenta";
      ".." = "z ..";
      update = "update.sh";
      b = "btop";
      mkdir = "mkdir -p";
      cmdf = "commit_dotfiles.sh";
      snap = "sudo snap";
      wifi = "wifi.sh";
      backup = "backup.sh";
      sl = "ls";
      zth = "zathura";
      ga = "git add";
      gb = "git branch";
      "g." = "git add . && git status";
      gs = "git status";
      gc = "git commit";
      gca = "git status && git add . && git commit --amend --no-edit";
      gp = "git push";
      gl = "git log --oneline --graph --decorate";
      gch = "git checkout";
      cr = "cargo run";
      ct = "cargo test";
      y = "yazi";
      wlist = "nmcli d wifi list";
      wconnect = "nmcli d wifi connect";
      convert = "convert_wallpaper.sh";
      fdf = "fzfdf.sh";
      remove_wallpaper = "remove_wallpaper.sh";
      picom-edit = "nano ~/.dotfiles/picom/.config/picom/picom.conf";
      i3-edit = "nano ~/.dotfiles/i3/.config/i3/config";
      polybar-edit = "code ~/.dotfiles/polybar/.config/polybar/.";
      fish-edit = "nano ~/.dotfiles/fish/.config/fish/config.fish";
      cp = "cp -r";
      rm = "rm -r";
    };
  };
}
