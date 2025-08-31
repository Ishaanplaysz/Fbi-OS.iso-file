#!/bin/bash
# FBI-OS update script

echo -e "\e[32mChecking for updates...\e[0m"
cd /root/fbi-os
sudo git pull
sudo apt-get update && sudo apt-get upgrade -y
echo -e "\e[32mSystem updated!\e[0m"
