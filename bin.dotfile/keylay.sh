#!/bin/sh

setxkbmap -device $(xinput --list | grep keyboard | grep Translated | awk '{print $7}' | awk '{split($0,a,"="); print a[2]}') -layout se

setxkbmap -device $(xinput --list | grep keyboard | grep CHESEN     | awk '{print $7}' | awk '{split($0,a,"="); print a[2]}') -layout us

xmodmap ~/.Xmodmap

