#!/bin/bash
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s "$(find ~/Pictures/Wallpapers -type f -name "*.bmp" -o -name "*jpg" -o -name "*.png" | sort -R | head -1)"

