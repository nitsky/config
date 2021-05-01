#!/usr/bin/env bash
alacritty --class launcher --command zsh -c "swaymsg -r -t get_outputs | jq -r '.[] | .name' | fzf"
