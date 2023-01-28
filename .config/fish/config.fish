if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Path

set PATH $HOME/.cargo/bin $PATH

# Zoxide
zoxide init fish | source

# Alias

# ls -> exa
if type -q exa
    alias l 'exa -1 --icons'
    alias la 'exa -l -a -h --icons --classify --group-directories-first --no-user'
    alias ld 'exa -l -a -h --list-dirs --no-user'
    alias ll 'exa -l -a -h --git --no-user'
    alias lt='exa -a --no-user --tree --level'
end

if type -q bat
    alias cat 'bat'
end

if type -q btm
    alias btm 'btm --battery'
end

# Abbr

# git 
abbr -a -g gst 'git status -sb'

# mkdir
abbr -a -g mkdir "mkdir -pv"

# ls
abbr -a -g ls "exa -1 --icons"
