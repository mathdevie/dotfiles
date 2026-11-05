export ZSH="$HOME/.oh-my-zsh"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Plugin order: zsh-autocomplete near the top (its docs: load before any
# compdef), then zsh-autosuggestions, with exactly ONE syntax highlighter LAST.
plugins=(git)

# zsh-autocomplete's async live-menu redraw corrupts the line editor in
# xterm.js terminals (T3 Code, which leaves TERM_PROGRAM unset, and VS Code).
# Load it only in real terminals; elsewhere tab-completion still works via omz.
if [ -n "$TERM_PROGRAM" ] && [ "$TERM_PROGRAM" != "vscode" ]; then
  plugins+=(zsh-autocomplete)
fi

plugins+=(zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source $ZSH/custom/goto/goto.sh
source <(fzf --zsh)

# User configuration
export PATH="$HOME/.local/bin:$HOME/go/bin/:$PATH"

# Node via fnm (brew install fnm): switches version on cd from .nvmrc /
# .node-version (searching parent dirs), else uses `fnm default`.
# Must come AFTER the PATH line above so fnm's node wins over the node that
# other tools (e.g. Hermes) symlink into ~/.local/bin.
if command -v fnm >/dev/null; then
  eval "$(fnm env --use-on-cd --version-file-strategy=recursive --shell zsh)"
fi

# Do not put commands in history if they begin with a SPACE
setopt HIST_IGNORE_SPACE

# Trim excessive whitespace from commands before adding to history
setopt HIST_REDUCE_BLANKS

# Limit space taken by autocompletion
zstyle -e ':autocomplete:*:*' list-lines 'reply=( $(( LINES / 3 )) )'

if [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
  : # plain prompt (oh-my-posh disabled)
elif [ "$TERM_PROGRAM" = "vscode" ] || [ -z "$TERM_PROGRAM" ]; then
  # VS Code + T3 Code (Electron/xterm.js: hardcoded non-Nerd font, sets no
  # TERM_PROGRAM) -> glyph-free config so the prompt doesn't render as boxes.
  eval "$(oh-my-posh init zsh --config $HOME/.oh-my-posh/config-minimal.omp.json)"
else
  eval "$(oh-my-posh init zsh --config $HOME/.oh-my-posh/config.omp.json)"
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
