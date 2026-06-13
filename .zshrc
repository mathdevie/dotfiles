export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

plugins+=(zsh-autosuggestions fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source $ZSH/custom/goto/goto.sh
source <(fzf --zsh)

# User configuration
export PATH="$HOME/.local/bin:$HOME/go/bin/:$PATH"

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

