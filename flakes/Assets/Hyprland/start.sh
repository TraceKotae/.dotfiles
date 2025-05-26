#! /usr/bin/env bash

#wallpaperstuff
swww-daemon &
sww img ~/.dotfiles/flakes/Assets/Wallpapers/SakuratreeLarge.png &

# run pipewire if its not already on
pipewire &
pipewire-pulse &
wireplumber &

#Waybar (not installed rn)
#waybar &

# Dunst notification agent (not enabled rn)
dunst
