export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export ZSH="$HOME/.oh-my-zsh"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)

source $ZSH/oh-my-zsh.sh
source $ZSH/custom/goto/goto.sh
source <(fzf --zsh)

# User configuration
export PATH="$HOME/go/bin/:$PATH"

# Do not put commands in history if they begin with a SPACE
setopt HIST_IGNORE_SPACE

# Trim excessive whitespace from commands before adding to history
setopt HIST_REDUCE_BLANKS

# Limit space taken by autocompletion
zstyle -e ':autocomplete:*:*' list-lines 'reply=( $(( LINES / 3 )) )'

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  if [ "$TERM_PROGRAM" = "vscode" ]; then
    eval "$(oh-my-posh init zsh --config $HOME/.oh-my-posh/config-minimal.omp.json)"
  else
    eval "$(oh-my-posh init zsh --config $HOME/.oh-my-posh/config.omp.json)"
  fi
fi

