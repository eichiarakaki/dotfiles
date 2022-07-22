set fish_greeting ""

starship init fish | source

set -x STARSHIP_CONFIG ~/.config/starship/starship.toml
set -x STARSHIP_CACHE ~/.config/starship/cache

alias ls "exa --group-directories-first"
alias l "ls -laSh"
alias tree "exa -T"
alias grep "grep --color=auto"

set -gx PATH "$HOME/.cargo/bin" $PATH;