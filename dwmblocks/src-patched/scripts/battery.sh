#!/usr/bin/env bash

VAL=$(upower -b | sed -n 's/.*percentage:[[:space:]]*\([0-9]\+\).*/\1/p')
OUT=$(upower -b | sed -n 's/.*state:[[:space:]]*\(.*\)/\1/p')
BAT_ARR=('󰂎' '󰁺' '󰁻' '󰁼' '󰁽' '󰁾' '󰁿' '󰂀' '󰂁' '󰂂' '󰁹')

case $OUT in
"discharging") echo -n "${BAT_ARR[$((VAL / 10))]}" ;;
"pending-charge") echo -n '󰂑' ;;
"charging") echo -n "󱐋${BAT_ARR[$((VAL / 10))]}" ;;
"fully-charged") echo -n '󱟢' ;;
*) [ "$VAL" != "" ] && echo 'none' ;;
esac

[ "$VAL" != "" ] && echo " $VAL%"
