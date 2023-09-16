# Path config
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.pyenv/bin

# Set variables
set -gx EDITOR hx

# initializations
starship init fish | source
zoxide init fish | source
pyenv init - | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Path

set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.local/bin $PATH

# Zoxide
zoxide init fish | source

# Alias

# ls -> exa
if type -q eza
    alias l 'eza --icons --group-directories-first'
    alias la 'eza -l -a -h --icons -F --group-directories-first --no-user'
    alias ld 'eza -l -a -h --list-dirs --no-user'
    alias ll 'eza -1 --icons --group-directories-first'
    alias lr 'eza -R -L'
    alias lt 'eza -a --no-user --tree --level'
end

# cat -> bat
if type -q bat
    alias cat 'bat'
end

# Use btop
if type -q btm
    alias btm 'btm --battery'
end

# cd -> zoxide
if type -q z
    alias cd 'z'
end

# Abbr

# git 
abbr -a -g gst 'git status -sb'

# mkdir
abbr -a -g mkdir "mkdir -pv"

