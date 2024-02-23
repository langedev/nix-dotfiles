#!/bin/sh

export DISPLAY=":0"
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
/home/pan/.nix-profile/bin/notify-send "$(/run/current-system/sw/bin/date +%H:%M)" -t $1
