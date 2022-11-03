#!/usr/bin/sh

# This module install rclone, a tool that allows you to configure
# a synchronized folder with OneDrive or other cloud solutions

sudo apt update
sudo apt install rclone

# Note: leave everything by default and select 22: Microsoft OneDrive
rclone config
# for the site, use search and search for "site" 

mkdir ~/onedrive
rclone --vfs-cache-mode writes mount "ForsseaOneDrive": ~/onedrive