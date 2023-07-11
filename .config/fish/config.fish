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

