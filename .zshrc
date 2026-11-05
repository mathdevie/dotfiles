export ZSH="$HOME/.oh-my-zsh"

# zsh-autocomplete garbles the line in xterm.js terminals (VS Code, T3 Code), so real terminals only
plugins=(git)
[[ -n $TERM_PROGRAM && $TERM_PROGRAM != vscode ]] && plugins+=(zsh-autocomplete)
plugins+=(zsh-autosuggestions zsh-syntax-highlighting)  # highlighter must stay last

source $ZSH/oh-my-zsh.sh
source <(fzf --zsh)

export PATH="$HOME/.local/bin:$PATH"

# After PATH, so fnm's node wins over any node in ~/.local/bin
(( $+commands[fnm] )) && eval "$(fnm env --use-on-cd --version-file-strategy=recursive --shell zsh)"

# oh-my-zsh only keeps 10k lines
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_SPACE HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS

zstyle -e ':autocomplete:*:*' list-lines 'reply=( $(( LINES / 3 )) )'

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
(( $+commands[bat] ))    && alias cat='bat --paging=never --style=plain'
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
(( $+commands[atuin] ))  && eval "$(atuin init zsh --disable-up-arrow --disable-ai)"  # AI mode hijacks `?`
