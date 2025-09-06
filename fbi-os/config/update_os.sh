#!/bin/bash
# FBI-OS auto-update script

echo -e "\e[32mChecking for updates...\e[0m"
cd /root/fbi-os

# Use GitHub token if available
if [ -f ~/.github_token ]; then
	GITHUB_TOKEN=$(cat ~/.github_token)
	git pull https://$GITHUB_TOKEN@github.com/Ishaanplaysz/Fbi-OS.iso-file.git main
else
	git pull origin main
fi

# Detect package manager
if command -v apt-get &> /dev/null; then
	sudo apt-get update && sudo apt-get upgrade -y
elif command -v dnf &> /dev/null; then
	sudo dnf update -y
fi

# Notify user
if [ $? -eq 0 ]; then
	echo -e "\e[32mSystem updated!\e[0m"
else
	echo -e "\e[31mUpdate failed!\e[0m"
fi
