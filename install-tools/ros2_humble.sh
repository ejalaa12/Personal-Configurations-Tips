#!/usr/bin/bash

# This module installs ros2 humble

install_ros_humble() {
    sudo apt update && sudo apt install locales
    sudo locale-gen en_US en_US.UTF-8
    sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
    export LANG=en_US.UTF-8
    sudo apt install -y software-properties-common
    sudo add-apt-repository -y universe
    sudo apt update && sudo apt install -y curl gnupg lsb-release
    sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list >/dev/null
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y ros-humble-desktop-full
}

ros_apps=(
    ros-humble-behaviortree-cpp-v3
    ros-humble-backward-ros
    ros-humble-ros2controlcli
    ros-humble-topic-tools
    ros-humble-rqt-robot-steering
    ros-humble-plotjuggler
    ros-humble-plotjuggler-msgs
    ros-humble-plotjuggler-ros
    # ros-humble-frs-ament-copyright
)

install_ros_apps() {
    echo "${ros_apps[@]}" | xargs sudo apt install -y
}

install_ros_aliases() {

    # Add aliases
    echo '# #############'
    echo '# ROS ALIASES  '
    echo '# #############'
    echo 'alias humble="source /opt/ros/humble/setup.zsh"' >>~/.aliases
    echo 'alias si="source install/setup.zsh"' >>~/.aliases
    echo 'alias sil="source install/local_setup.zsh"' >>~/.aliases
    echo 'alias tf2echo="ros2 run tf2_ros tf2_echo"' >>~/.aliases
    echo 'alias wros="echo $ROS_DISTRO"' >>~/.aliases

    echo "humble" >>~/.zshrc

}
