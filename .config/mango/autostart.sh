#! /bin/bash
set +e

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
# The next line of command is not necessary. It is only to avoid some situations where it cannot start automatically
/usr/lib/xdg-desktop-portal-wlr &

qs -c noctalia-shell &
udiskie --tray &
insync start &
hypridle &

wl-clip-persist --clipboard regular --reconnect-tries 0 &
wl-paste --type text --watch cliphist store &
