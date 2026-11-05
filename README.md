# dotfiles

zsh (oh-my-zsh + oh-my-posh), git, and the CLI tools around them, symlinked
into `~` with [GNU Stow](https://www.gnu.org/software/stow/).

## New Mac

```sh
# 1. Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. oh-my-zsh (keep the existing .zshrc when it asks)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

# 3. This repo, with plugin submodules
git clone --recursive git@github.com:mathdevie/dotfiles.git ~/Code/dotfiles
cd ~/Code/dotfiles

# 4. Everything in the Brewfile (prune it first if you don't want all the apps)
brew bundle

# 5. Link into ~ (move any existing ~/.zshrc etc. out of the way first)
rm -rf ~/.oh-my-zsh/custom && ln -s ~/Code/dotfiles/.oh-my-zsh/custom ~/.oh-my-zsh/custom
stow .

# 6. Node
fnm install 22 && fnm install 24 && fnm default 22
npm install -g firebase-tools yarn

# 7. Shell history into atuin
atuin import zsh
```

## Machine-local, never committed

| File | For |
|---|---|
| `~/.secrets/zsh.env` | API tokens. Sourced by `.zshenv`; keep it `chmod 600`. |
| `~/.gitconfig` | Per-machine git: `includeIf` for work repos, signing, maintenance. Read after the tracked `~/.config/git/config`, so it wins. |

## What's where

- `.zshenv`: every shell. Cargo, secrets.
- `.zprofile`: login shells. Homebrew and PATH.
- `.zshrc`: interactive shells. oh-my-zsh, prompt, fnm, history, tools.
- `.config/git/`: shared git config (delta as pager) and global ignore.
- `.oh-my-posh/`: prompt themes (full, plus a glyph-free one for VS Code / xterm.js).
- `.oh-my-zsh/custom/plugins/`: zsh-autocomplete, zsh-autosuggestions, zsh-syntax-highlighting as submodules. Update with `git submodule update --remote`.
- `Brewfile`: regenerate with `brew bundle dump --force --no-vscode --no-go --no-cargo --no-uv --no-mas`.

## Daily

| Command | Does |
|---|---|
| `z <part>` / `zi` | Jump to a frequent dir (zoxide) / pick one with fzf |
| `Ctrl-R` | Search shell history (atuin) |
| `Ctrl-T` | Insert a file path (fzf) |
| `ll`, `la`, `tree` | eza listings with git status |
| `.envrc` + `direnv allow` | Per-project env vars |
