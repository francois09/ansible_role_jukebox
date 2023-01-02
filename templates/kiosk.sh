#!/bin/bash
unclutter -idle 0.5 -root &
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' /home/{{ jukebox__default_user }}/.config/chromium/Default/Preferences
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' /home/{{ jukebox__default_user }}/.config/chromium/Default/Preferences
/usr/bin/chromium --noerrdialogs --disable-infobars --kiosk http://127.0.0.1:6680/iris &
