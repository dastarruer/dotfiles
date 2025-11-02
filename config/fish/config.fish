# Remove greeting
set -g fish_greeting ""
fastfetch

# Aliases
alias code="codium"
alias chx="chmod +x"
alias pr="python3 main.py"
alias df="cd ~/.dotfiles"
alias grep="grep -i"
alias ..="z .."
alias b="btop"
alias mkdir="mkdir -p"
alias cmdf="commit-dotfiles.sh"
alias backup="backup.sh"
alias sl="ls"
alias zth="zathura"
alias ga="git add"
alias gb="git branch"
alias g.="git add . && git status"
alias gs="git status"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"
alias gch="git checkout"
alias cr="cargo run"
alias ct="cargo test"
alias y="yazi"
alias fdf="fzfdf.sh"
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
