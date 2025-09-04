#!/bin/bash
# FBI-OS update notification script

LATEST_COMMIT=$(git ls-remote origin -h refs/heads/main | awk '{print $1}')
LOCAL_COMMIT=$(git rev-parse HEAD)

if [ "$LATEST_COMMIT" != "$LOCAL_COMMIT" ]; then
  echo -e "\e[33mA new update is available for FBI-OS!\e[0m"
  echo -e "Click the update button to get the latest features."
else
  echo -e "\e[32mYour FBI-OS is up to date.\e[0m"
fi
