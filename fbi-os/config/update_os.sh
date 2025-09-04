#!/bin/bash
# FBI-OS update script

echo -e "\e[32mChecking for updates...\e[0m"
cd /root/fbi-os
sudo git pull
sudo dnf update -y

# Check for new updates and notify user
if [ $? -eq 0 ]; then
	echo -e "\e[32mSystem updated!\e[0m"
else
	echo -e "\e[31mUpdate failed!\e[0m"
fi
echo -e "\e[32mSystem updated!\e[0m"
