#!/usr/bin/sh

# This module installs ros2 humble

sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
sudo apt install software-properties-common
sudo add-apt-repository universe
sudo apt update && sudo apt install curl gnupg lsb-release
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
sudo apt update
sudo apt upgrade
sudo apt install ros-humble-desktop-full
sudo apt install ros-humble-behaviortree-cpp-v3
sudo apt install ros-humble-backward-ros
sudo apt install ros-humble-ros2controlcli
sudo apt install ros-humble-topic-tools
sudo apt install ros-humble-rqt-robot-steering
sudo apt install ros-humble-plotjuggler
sudo apt install ros-humble-plotjuggler-msgs
sudo apt install ros-humble-plotjuggler-ros
sudo apt install ros-humble-frs-ament-copyright

# Add aliases
echo '# #############'
echo '# ROS ALIASES  '
echo '# #############'
echo 'alias humble="source /opt/ros/humble/setup.zsh"' >> ~/.aliases
echo 'alias si="source install/setup.zsh"' >> ~/.aliases
echo 'alias sil="source install/local_setup.zsh"' >> ~/.aliases
echo 'alias tf2echo="ros2 run tf2_ros tf2_echo"' >> ~/.aliases
echo 'alias wros="echo $ROS_DISTRO"' >> ~/.aliases

echo "humble" >> ~/.zshrc
