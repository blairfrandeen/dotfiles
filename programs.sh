#!/bin/bash

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
install vim-gtk3
install screen
install fzf
install tree
install git
install curl
install gcc
install tmux
install linux-tools-common
install linux-tools-generic
install linux-tools-`uname -r`
install pandoc

# Window manager
install i3

# Media processing
install ffmpeg
install lame

# Make vim the default editor
sudo update-alternatives --set editor /usr/bin/vim.basic

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
