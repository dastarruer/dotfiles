if status --is-interactive
    # Aliases
    alias chx="chmod +x"
    alias pr="python3 main.py"
    alias ps="sudo auto-cpufreq --force powersave"
    alias p="sudo auto-cpufreq --force performance"
    alias stats="sudo auto-cpufreq --stats"
    alias pls="sudo"
    alias save="save_workspace_layouts.sh"
    alias restore="restore_workspace_layouts.sh"
    alias stats="sudo auto-cpufreq --stats"
    alias stast="sudo auto-cpufreq --stats"
    alias df="cd ~/.dotfiles"
    alias grep="grep -i"
    alias apt="sudo apt"
    alias timeshift="sudo timeshift"
    alias pipes="pipes -p 10"
    alias cmatrix="cmatrix -u 3 -C magenta"
    alias ..="z .."
    alias update="update.sh"
    alias b="btop"
    alias mkdir="mkdir -p"
    alias cmdf="commit_dotfiles.sh"
    alias snap="sudo snap"
    alias wifi="wifi.sh"
    alias backup="backup.sh"
    alias sl="ls"
    alias zth="zathura"
    alias ga="git add"
    alias gb="git branch"
    alias g.="git add . && git status"
    alias gs="git status"
    alias gc="git commit -m"
    alias gca="git status && git add . && git commit --amend --no-edit"
    alias gp="git push & disown"
    alias gl="git log --oneline --graph --decorate"
    alias gch="git checkout"
    alias cr="cargo run"
    alias ct="cargo test"
    alias y="yazi"
    alias ai="ollama run llama3.2"    
    alias wlist="nmcli d wifi list"
    alias wconnect="nmcli d wifi connect"
    alias convert="convert_wallpaper.sh"
    alias fdf="fzfdf.sh"
    alias remove_wallpaper="remove_wallpaper.sh"
    alias picom-edit="nano ~/.dotfiles/picom/.config/picom/picom.conf"
    alias i3-edit="nano ~/.dotfiles/i3/.config/i3/config"
    alias polybar-edit="code ~/.dotfiles/polybar/.config/polybar/."
    alias fish-edit="nano ~/.dotfiles/fish/.config/fish/config.fish"
    alias cp="cp -r"
    alias rm="rm -r"
end
# Remove greeting when starting a new terminal
set -g fish_greeting ""

# Add spicetify to PATH
fish_add_path /home/dastarruer/.spicetify

# Add .local/bin to PATH
set -U fish_user_paths $HOME/.local/bin $fish_user_paths
set -Ux fish_user_paths $HOME/.cargo/bin $fish_user_paths

export STARSHIP_CONFIG=~/.cache/wal/starship.toml

# Start Starship prompt
starship init fish | source

neofetch

# zoxide
zoxide init fish | source

# Pywal colors
if test -e ~/.cache/wal/colors.fish
    source ~/.cache/wal/colors.fish
end

# pnpm
set -gx PNPM_HOME "/home/dastarruer/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
