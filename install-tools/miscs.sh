#!/usr/bin/sh

# This module installs all tools that do not fit anywhere



# ------- LAZYGIT -------------
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' |  sed -E 's/.*"v*([^"]+)".*/\1/')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit

echo 'alias lg="lazygit"' >> ~/.aliases

# ------- KEEPASSXC -------------
sudo add-apt-repository ppa:phoerious/keepassxc
sudo apt-get update
sudo apt install keepassxc