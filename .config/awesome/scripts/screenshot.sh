#!/bin/sh -e

CURRENTDATETIME=`date +"%Y-%m-%d_%T"`

selection=$(hacksaw)
shotgun $selection | xclip -t 'image/png' -selection primary
shotgun -g "$selection" $HOME/Pictures/Screenshots/screenshot_$CURRENTDATETIME.png
