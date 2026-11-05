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

# History. oh-my-zsh already sets share_history, hist_ignore_dups and
# extended_history (and caps SAVEHIST at 10k); these go on top.
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_SPACE     # commands starting with a space aren't recorded
setopt HIST_IGNORE_ALL_DUPS  # re-running a command drops its older copy
setopt HIST_REDUCE_BLANKS    # trim excess whitespace before saving

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

# CLI tools (all in the Brewfile; each is skipped if not installed).
# Keep this block LAST: zoxide, direnv and atuin all hook the prompt/cd and
# want to load after everything else; atuin must come after fzf to own Ctrl-R.
if (( $+commands[eza] )); then
  alias ls='eza --group-directories-first'
  alias l='eza -la --git --group-directories-first'
  alias ll='eza -l --git --group-directories-first'
  alias la='eza -la --git --group-directories-first'
  alias tree='eza --tree --git-ignore'
fi
(( $+commands[bat] ))    && alias cat='bat --paging=never --style=plain'
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"    # z <partial>, zi = pick with fzf
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"    # per-project .envrc
# atuin: Ctrl-R only. Keep the up arrow for zsh-autocomplete, and skip atuin's
# hosted AI prompt (it would otherwise take over `?` on an empty line).
(( $+commands[atuin] ))  && eval "$(atuin init zsh --disable-up-arrow --disable-ai)"
