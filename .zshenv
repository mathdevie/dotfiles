typeset -U path PATH  # no duplicate PATH entries

[ -r "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Untracked secrets. Here rather than .zshrc so scripts and non-interactive shells get them too
[ -r "$HOME/.secrets/zsh.env" ] && source "$HOME/.secrets/zsh.env"
