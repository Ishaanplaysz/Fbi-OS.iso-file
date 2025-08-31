#!/bin/bash
# FBI-OS multi-layer password login

echo -e "\e[32mFBI Secure Access Terminal\e[0m"
echo -e "\e[32mInitializing multi-layer password protection...\e[0m"
read -p "Enter number of password layers (1-10): " layers

for ((i=1; i<=layers; i++)); do
  read -s -p "Set password for layer $i: " pass[i]
  echo
done

echo -e "\e[32mBypassing password layers...\e[0m"
for ((i=1; i<=layers; i++)); do
  read -s -p "Enter password for layer $i: " input
  echo
  if [[ "$input" != "${pass[i]}" ]]; then
    echo -e "\e[31mAccess Denied!\e[0m"
    exit 1
  fi
  echo -e "\e[32mLayer $i bypassed...\e[0m"
done

echo -e "\e[32mAccess Granted! Welcome to FBI-OS.\e[0m"
# Start desktop environment here
