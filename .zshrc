# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
  git
  zsh-autocomplete
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
source $ZSH/goto.sh

# User configuration
export PATH="$HOME/go/bin/:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Do not put commands in history if they begin with a SPACE
setopt HIST_IGNORE_SPACE

# Trim excessive whitespace from commands before adding to history
setopt HIST_REDUCE_BLANKS
