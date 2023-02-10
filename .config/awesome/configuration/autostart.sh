#!/bin/bash

cd $(dirname $0)

function exe () {
    local cmd=$@
    if ! pgrep -x $cmd; then
        $cmd &
    fi
}

sleep 1
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal
sleep 1
exe /usr/lib/xdg-desktop-portal

exe ~/.xrandr
exe polkit-dumb-agent
exe picom --config ~/.config/picom/picom.conf -b
exe nm-applet --indicator
exe blueman-applet
exe thunar --daemon