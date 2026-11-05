# dotfiles

My zsh setup. Needs Homebrew and oh-my-zsh.

```sh
git clone --recursive git@github.com:mathdevie/dotfiles.git ~/Code/dotfiles
cd ~/Code/dotfiles
brew bundle
stow .
```

Secrets go in `~/.secrets/zsh.env`, which isn't tracked.
