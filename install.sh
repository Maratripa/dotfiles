#!/usr/bin/bash

# packages
paru -S hacksaw shotgun # screenshot utils

paru -S xclip # clipboard

paru -S setxkbmap # keyboard layout

# Pacman configuration
sed -i '23i ILoveCandy' /etc/pacman.conf
