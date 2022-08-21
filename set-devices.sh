#!/usr/bin/sh

# Add /usr/bin/setxkbmap if not on the PATH
setxkbmap -layout pl -option "ctrl:nocaps"
echo "Language set to PL"
echo "Ctrl set to CapsLock"

# to set a typematic DELAY to 200ms and a typematic RATE to 50Hz
xset r rate 200 70
echo "MORE SPEED!!!!!!!!!!!!!!!!!!!!!!!!!!1111"

xmodmap ~/.Xmodmap
echo "Source ~/.Xmodmap"

xinput set-prop "TPPS/2 Elan TrackPoint" "libinput Natural Scrolling Enabled" 1
xinput set-prop "TPPS/2 Elan TrackPoint" "libinput Accel Speed" 0.6
xinput set-prop 'TPPS/2 Elan TrackPoint' "libinput Scrolling Pixel Distance" 10
xinput set-prop "SYNA8009:00 06CB:CE57 Touchpad" "libinput Accel Speed" 1
xinput set-prop "SYNA8009:00 06CB:CE57 Touchpad" "libinput Natural Scrolling Enabled" 1
xinput set-prop "SYNA8009:00 06CB:CE57 Touchpad" "libinput Tapping Enabled" 1
xinput set-prop "SYNA8009:00 06CB:CE57 Touchpad" "libinput Scrolling Pixel Distance" 10
xinput set-prop "MOSART Semi. Trust Wireless Mouse" "libinput Accel Speed" 1
xinput set-prop "MOSART Semi. Trust Wireless Mouse" "libinput Scrolling Pixel Distance" 10
xinput set-prop "PixArt HP Travel USB Optical Mouse" "libinput Accel Speed" 1
xinput set-prop "PixArt HP Travel USB Optical Mouse" "libinput Scrolling Pixel Distance" 10
echo "Mouse settings applied"
notify-send "Devices settings set"
