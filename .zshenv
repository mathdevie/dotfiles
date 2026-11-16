typeset -U path PATH

[ -r "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Untracked secrets
[ -r "$HOME/.secrets/zsh.env" ] && source "$HOME/.secrets/zsh.env"
