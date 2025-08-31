#!/bin/bash
# Post-install script for FBI-OS

# Apply Openbox theme
cp /usr/share/fbi-os-assets/openbox_theme_green.rc ~/.config/openbox/rc.xml
# Set up autostart
cp /etc/fbi-os-config/fbi-autostart.sh ~/.config/openbox/autostart
chmod +x ~/.config/openbox/autostart
# Set up login script
cp /etc/fbi-os-config/fbi-login.sh /usr/local/bin/fbi-login
chmod +x /usr/local/bin/fbi-login
# Set up update script
cp /etc/fbi-os-config/update_os.sh /usr/local/bin/update_os
chmod +x /usr/local/bin/update_os
# Set up app downloader
cp /etc/fbi-os-config/app_downloader.sh /usr/local/bin/app_downloader
chmod +x /usr/local/bin/app_downloader
