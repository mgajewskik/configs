#! /bin/bash
set +e

dbus-update-activation-environment --systemd \
    DISPLAY \
    WAYLAND_DISPLAY \
    XDG_RUNTIME_DIR \
    DBUS_SESSION_BUS_ADDRESS \
    XDG_SESSION_TYPE \
    XDG_CURRENT_DESKTOP=wlroots

# systemctl --user restart handy.service
