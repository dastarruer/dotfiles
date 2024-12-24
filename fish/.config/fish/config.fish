if status --is-interactive
    # Aliases
    alias save="save_workspace_layouts.sh"
    alias restore="restore_workspace_layouts.sh"

    alias df="cd ~/dotfiles"
    alias update="sudo apt update && sudo apt upgrade"
    alias grep="grep -i"
    alias apt="sudo apt"
    alias timeshift="sudo timeshift"
    alias pipes="pipes -p 10"
    alias cmatrix="cmatrix -u 3 -C magenta"
    alias ..="cd .."
    alias b="btop"
    
    # Git Aliases
    alias ga="git"
    alias gb="git branch"
    alias g.="git add . && git status"
    alias gs="git status"
    alias gc="git commit -m"
    alias gp="git push"
    alias gl="git log"

    alias picom="picom --transparent-clipping"

    # Fzf
    alias fdf="fzfdf.sh"

    alias picom-edit="nano ~/dotfiles/picom/.config/picom/picom.conf"
    alias i3-edit="nano dotfiles/i3/.config/i3/config"
    alias polybar-edit="code dotfiles/polybar/.config/polybar/."

    # Games
    # To create a steam game function:
        # This is the proton prefix that the game will be played in (note that the directory specified has to be created manually)
            # env STEAM_COMPAT_DATA_PATH=$HOME/.local/share/Steam/steamapps/compatdata/{game_name} \
        # This is where steam is installed
            # STEAM_COMPAT_CLIENT_INSTALL_PATH=$HOME/.steam/debian-installation \
        # Specify the path to proton, and run
            # $HOME/.steam/steam/steamapps/common/Proton\ 9.0\ \(Beta\)/proton run \
            # path/to/executable
    function superhot
        env STEAM_COMPAT_DATA_PATH=$HOME/.local/share/Steam/steamapps/compatdata/superhot \
        STEAM_COMPAT_CLIENT_INSTALL_PATH=$HOME/.steam/debian-installation \
        $HOME/.steam/steam/steamapps/common/Proton\ 9.0\ \(Beta\)/proton run \
        $HOME/Games/SUPERHOT/SH.exe
    end 

    function hitman
        env STEAM_COMPAT_DATA_PATH=$HOME/.local/share/Steam/steamapps/compatdata/hitman \
        STEAM_COMPAT_CLIENT_INSTALL_PATH=$HOME/.steam/debian-installation \
        $HOME/.steam/steam/steamapps/common/Proton\ 9.0\ \(Beta\)/proton run \
        $HOME/Games/HITMAN\ World\ of\ Assassination/Launcher.exe
    end

    # Safer aliases for cp and rm
    alias cp="cp -r"
    alias rm="rm -r"
end
# Remove greeting when starting a new terminal
set -g fish_greeting ""

# Add spicetify to PATH
fish_add_path /home/dastarruer/.spicetify

# Add .local/bin to PATH
set -U fish_user_paths $HOME/.local/bin $fish_user_paths

# Disable touchpad palm rejection
xinput set-prop "ELAN06FA:00 04F3:32B9 Touchpad" "libinput Disable While Typing Enabled" 0

# Start Starship prompt
starship init fish | source

neofetch
