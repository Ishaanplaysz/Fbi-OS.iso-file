#!/bin/bash
# Autostart script for FBI-OS desktop

# Set wallpaper
feh --bg-scale /usr/share/fbi-os-assets/fbi_wallpaper.png
# Start conky for FBI code effect
conky -c /etc/fbi-os-config/conky_fbi.conf &
# Start desktop environment
bash /etc/fbi-os-config/fbi-desktop.sh
