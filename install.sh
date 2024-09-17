#!/bin/sh
# https://gist.github.com/n1snt/454b879b8f0b7995740ae04c5fb5b7df
zshrc() {
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone --depth=1 https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

    git clone --depth=1 https://github.com/iridakos/goto.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/goto

    cat .zshrc > $HOME/.zshrc
    cat .p10k.zsh > $HOME/.p10k.zsh
}

zshrc
