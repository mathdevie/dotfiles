export ZSH="$HOME/.oh-my-zsh"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)  # highlighting must stay last

source $ZSH/oh-my-zsh.sh
source <(fzf --zsh)
# fzf opens under the prompt instead of full screen; Ctrl-T previews files with bat
export FZF_DEFAULT_OPTS="--height 40% --layout reverse --border"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range :40 {}'"

export PATH="$HOME/.local/bin:$PATH"

# fnm has faster loads than nvm
(( $+commands[fnm] )) && eval "$(fnm env --use-on-cd --version-file-strategy=recursive --shell zsh)"

# oh-my-zsh only keeps 10k lines
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_SPACE HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS

# No prompt theme in Apple Terminal; glyph-free one where there's no Nerd Font
if [[ $TERM_PROGRAM == Apple_Terminal ]]; then
  :
elif [[ $TERM_PROGRAM == vscode || -z $TERM_PROGRAM ]]; then
  eval "$(oh-my-posh init zsh --config $HOME/.oh-my-posh/config-minimal.omp.json)"
else
  eval "$(oh-my-posh init zsh --config $HOME/.oh-my-posh/config.omp.json)"
fi

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Keep last: these hook cd/prompt, and atuin has to come after fzf to get Ctrl-R
if (( $+commands[eza] )); then
  alias ls='eza --group-directories-first'
  alias ll='ls -l --git'
  alias la='ls -la --git'
  alias l='la'
  alias tree='eza --tree --git-ignore'
fi
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
(( $+commands[atuin] ))  && eval "$(atuin init zsh --disable-up-arrow --disable-ai)"  # AI mode hijacks `?`
