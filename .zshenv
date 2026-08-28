. "$HOME/.cargo/env"

# Load machine-local secrets without tracking them in this repository.
# .zshenv runs for every shell (including non-interactive), so tools invoked
# outside an interactive session still see these variables.
[[ -r "$HOME/.secrets/zsh.env" ]] && source "$HOME/.secrets/zsh.env"
