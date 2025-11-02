# Remove greeting
set -g fish_greeting ""
fastfetch

# Aliases
alias code="codium"
alias chx="chmod +x"
alias pr="python3 main.py"
alias ps="sudo auto-cpufreq --force powersave"
alias p="sudo auto-cpufreq --force performance"
alias stats="sudo auto-cpufreq --stats"
alias pls="sudo"
alias save="save_workspace_layouts.sh"
alias restore="restore_workspace_layouts.sh"
alias stast="sudo auto-cpufreq --stats"
alias df="cd ~/.dotfiles"
alias grep="grep -i"
alias timeshift="sudo timeshift"
alias pipes="pipes -p 10"
alias cmatrix="cmatrix -u 3 -C magenta"
alias ..="z .."
alias update="update.sh"
alias b="btop"
alias mkdir="mkdir -p"
alias cmdf="commit-dotfiles.sh"
alias snap="sudo snap"
alias wifi="wifi.sh"
alias backup="backup.sh"
alias sl="ls"
alias zth="zathura"
alias ga="git add"
alias gb="git branch"
alias g.="git add . && git status"
alias gs="git status"
alias gc="git commit"
alias gca="git status && git add . && git commit --amend --no-edit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"
alias gch="git checkout"
alias cr="cargo run"
alias ct="cargo test"
alias y="yazi"
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


# Starship
function starship_transient_prompt_func
  starship module character
end
starship init fish | source
enable_transience

# Zoxide
zoxide init fish | source

# Add ~/bin to the PATH if it’s not already there
if not contains $HOME/bin $PATH
    set -gx PATH $HOME/bin $PATH
end

# nix-direnv
eval (direnv hook fish)

# Tell electron apps to use wayland (https://nixos.wiki/wiki/Wayland)
set -x NIXOS_OZONE_WL "1"

# Allow unfree packages
set -x NIXPKGS_ALLOW_UNFREE "1"
