#!/usr/bin/bash

sudo apt update

# ###########################################################
# Install APT and snap packages
# ###########################################################
. ./app_list.sh

echo "# ###################################"
echo "# Installing [ " ${apt_apps[@]} " ] with APT"
echo "# ###################################"

echo "${apt_apps[@]}" | xargs sudo apt install -y

echo "# ###################################"
echo "# Installing [ ${snap_apps[@]} ] with SNAP"
echo "# ###################################"

for app in "${snap_apps[@]}"; do
    echo "Installing $app with snap"
    snap install $app
done

echo "# ###################################"
echo "# Installing [ ${deb_apps[@]} ] manually"
echo "# ###################################"

for app in ${deb_apps[@]}; do
    filename=$(echo $app | rev | cut -d'/' -f1 | rev)
    wget $app -P /tmp/
    sudo dpkg -i /tmp/$filename
done

# ###########################################################
# Install ROS Humble
# ###########################################################
. ros2_humble.sh

install_ros_humble
install_ros_apps
install_ros_aliases

# ###########################################################
# Install oh my zsh
# ###########################################################

# zsh is in the apt_apps list already
chsh -s /bin/zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "# ZSH aliases" >>~/.aliases
cat ../zsh/.aliases >>~/.aliases
# edit the zsh plugins, allow hyphen-insensitive, change theme
zsh_plugins=(
    git
    zsh-autosuggestions
    history
    sudo
    python
    taskwarrior
    zsh-interactive-cd
    jump
    jfrog
)
sed -i 's/plugins=(.*)/plugins=(${zsh_plugins})/g' ~/.zshrc
sed -i 's/# HYPHEN\(.*\)/HYPHEN\1/g' ~/.zshrc
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="ys"/g' ~/.zshrc
sed -i '85,89s/# \(.*\)/\1/g' ~/.zshrc
sed -i '86s/vim/nvim/g' ~/.zshrc
sed -i '88s/mvim/nvim/g' ~/.zshrc
sed -i 's/# alias zshconfig=\"mate/alias zshconfig=\"nvim/g' ~/.zshrc

# ###########################################################
# Install Node JS
# ###########################################################

curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash -
sudo apt-get install -y nodejs

# ###########################################################
# Install NeoVim plugins and config
# ###########################################################

mkdir -p ~/.config/nvim
cp ../nvim/init.vim ~/.config/nvim/init.vim

# Install Neovim Plug-Vim manager
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

nvim -c 'PlugUpgrade | PlugUpdate | qa'

# ###########################################################
# Install Lazygit
# ###########################################################

LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v*([^"]+)".*/\1/')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit

echo '' >>~/.aliases
echo 'alias lg="lazygit"' >>~/.aliases

# ###########################################################
# Install KeePassXc
# ###########################################################
sudo add-apt-repository -y ppa:phoerious/keepassxc
sudo apt-get update
sudo apt install -y keepassxc

# ###########################################################
# Config rclone
# ###########################################################

mkdir ~/onedrive
# rclone config

# ###########################################################
# Clang-16
# ###########################################################

wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
sudo add-apt-repository -y 'deb http://apt.llvm.org/focal/ llvm-toolchain-focal main'
sudo apt update && sudo apt install -y clang-format-16 clangd-16 clang-16 clang-tools-16 clang-tidy-16
sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-16 100
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-16 100
sudo update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-16 100
sudo update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-16 100

# ###########################################################
# Rename all folders to lowercase
# ###########################################################

rename 'y/A-Z/a-z/' *
mkdir ~/dev

# ###########################################################
# Set Default applications
# ###########################################################

sudo update-alternatives --set x-terminal-emulator /usr/bin/tilix.wrapper

# TODO: install docker
