#!/bin/bash
# Simple app downloader for FBI-OS

echo -e "\e[32mFBI App Downloader\e[0m"
read -p "Enter package name to install: " pkg
sudo apt-get install -y "$pkg"
echo -e "\e[32mInstallation complete.\e[0m"
