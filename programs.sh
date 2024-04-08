#!/bin/bash

sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update

function install {
    which $1 &> /dev/null

   if [ $? -ne 0 ]; then
        echo "Installing: ${1}..."
        sudo apt install -y $1
    else
        echo "Already Installed: ${1}"
    fi
}



# Basics
install vim
install neovim
install vim-gtk3
install screen
install tree
install git
install curl
install tmux
install maim
install pandoc
install fish

# Fonts
curl -fLo "FiraCode Nerd Font Complete.otf" \
https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/FiraCode/complete/FiraCode%20Nerd%20Font%20Complete.otf

# Terminal setup
install terminator
# Install terminator theme picker
wget https://git.io/v5Zww -O $HOME"/.config/terminator/plugins/terminator-themes.py"

# fzf - install via git w/ bash script to get keybindings & latest version
# important to install and run setup script _after_ zsh & terminator
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Developer stuff
install gcc
install linux-tools-common
install linux-tools-generic
install linux-tools-`uname -r`
install pkg-config
install libssl-dev
install sqlite
install libpq-dev
install libmysqlclient-dev
install libsqlite3-dev
install clangd-15
install libstdc++-12-dev
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-15 100

# Window manager
install i3

# Media processing
install ffmpeg
install lame
install imagemagick

# Make neovim the default editor
sudo update-alternatives --set editor /usr/bin/nvim

# Node.js for nvim/coc
curl -sL install-node.vercel.app/lts | sudo bash
# Install plug.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# Install vim plugins
vim -c 'PlugInstall' -c 'qa!'

# Python
install ipython3
install python3-pip
install python3.10-venv
pip install black --exists-action a -q

# Rust
which cargo &> /dev/null
if [ $? -ne 0 ]; then
    echo "Installing Rust!"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
    echo "Rust is Already Installed"
fi

# Visual Studio Code
which code &> /dev/null
if [ $? -ne 0 ]; then
    echo "Installing VSCode!"
    # https://code.visualstudio.com/docs/setup/linux
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt install -y apt-transport-https
    sudo apt update
    sudo apt install -y code
    rm microsoft.gpg
else
    echo "VSCode is Already Installed"
fi

# GitHub CLI
which gh &> /dev/null
if [ $? -ne 0 ]; then
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
else
    echo "GitHub CLI is already installed"
fi

# Espanso
wget https://github.com/federico-terzi/espanso/releases/download/v2.1.8/espanso-debian-x11-amd64.deb
install ./espanso-debian-x11-amd64.deb
espanso service register
espanso start

# Obsidian
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v1.2.7/obsidian_1.2.7_amd64.deb
install ./obsidian_1.2.7_amd64.deb
