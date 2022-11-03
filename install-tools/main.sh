#!/usr/bin/sh


sudo apt update

# ###########################################################
# Install APT and snap packages
# ###########################################################

. ./app_list.sh

for app in $snap_apps do
    echo "Installing $app with snap"
    snap install $app
done

echo "# #################################"
echo "# Installing [ $apt_apps ] with APT"
echo "# #################################"

echo $apt_apps | xargs sudo apt install -y

echo "# #################################"
echo "# Installing [ $apt_apps ] with APT"
echo "# #################################"

# ###########################################################
# Install ROS Humble
# ###########################################################
. ros2_humble.sh
