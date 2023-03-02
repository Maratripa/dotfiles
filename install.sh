#!/usr/bin/bash

clear

if command -v pacman > /dev/null; then

update() {
  cat << EOF

  [ System Update ]

  EOF

  sleep 3;
  su -c 'pacman -Syu --noconfirm'
  sleep 3; clear
}

sourcedeps() {
  cat << EOF

  [ Source Dependencies ]

  EOF

  sleep 3;
  if ! command -v paru &> /dev/null; then
    su -c 'pacman -S git base-devel --noconfirm --needed'
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    pushd /tmp/paru
    makepkg -si --noconfirm
    popd
  else
    echo -e "\n(*) It seems that you already have paru installed, skipping..."
  fi
  sleep 3; clear
}

deps () {
  cat << EOF

  [ Dependencies ]

  EOF

  sleep 3;
  paru -S base-devel xorg pipewire --needed --noconfirm
  yes | paru -S xclip xorg-xprop xdg-user-dirs awesome-git rofi 
}

setup() {
  sleep 3;

  echo "Copying files, please wait..."

  pushd ~/dotfiles
  cp -r . ~/
  popd

  fc-cache -fv
  xrdb ~/.Xresources
  xdg-user-dirs-update
  mkdir ~/Pictures/Screenshots
  mkdir ~/Pictures/Wallpapers

  sleep 3; clear
}

#
# Run!
#

update
sourcedeps
deps
setup

#
# End
#

echo "Ready!"