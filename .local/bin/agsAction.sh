#!/usr/bin/env bash

for ((i=0; i<$(xrandr --listmonitors | grep -c 'Monitor'); i++)); do ags -t "$1""$i"; done
