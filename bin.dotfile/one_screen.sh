#!/bin/sh
xrandr --output DP2 --off
xrandr --output LVDS1 --mode 1366x768 --pos 0x0
xfconf-query -c xfce4-panel -p /panels/panel-0/output-name -s LVDS1

