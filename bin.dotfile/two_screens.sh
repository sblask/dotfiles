#!/bin/sh
xrandr --output DP2 --mode 2560x1080 --pos 0x0
xrandr --output LVDS1 --mode 1366x768 --pos 2560x1080
xfconf-query -c xfce4-panel -p /panels/panel-0/output-name -s DP2

