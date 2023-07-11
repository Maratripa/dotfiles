#!/bin/bash

cd $(dirname $0)

function exe () {
    local cmd=$@
    if ! pgrep -x $cmd; then
        $cmd &
    fi
}

exe picom --config ~/.config/picom/picom.conf -b
exe birdtray
#exe nm-applet --indicator
#exe blueman-applet
#exe thunar --daemon
