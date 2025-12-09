#!/bin/bash
# Variables para Wayland
# export MOZ_ENABLE_WAYLAND=1
# export QT_QPA_PLATFORM=wayland
# export GDK_BACKEND=wayland

# Reload nm-applet
killall nm-applet
nm-applet &

# Reload mako
killall mako
mako &

# Initialize Waybar
~/.config/waybar/scripts/load-waybar.sh

# Reload background
killall swaybg
sh ~/.config/mango/scripts/fondo.sh

# keep clipboard content
wl-clip-persist --clipboard regular --reconnect-tries 0 &

# clipboard content manager
wl-paste --type text --watch cliphist store & 
