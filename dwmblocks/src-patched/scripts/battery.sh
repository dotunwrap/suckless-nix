#!/bin/sh

export VAL="$(echo -n "$(upower -b | sed -n 's/.*percentage:[[:space:]]*\([0-9]\+\).*/\1/p')")"
export OUT="$(echo -n "$(upower -b | sed -n 's/.*state:[[:space:]]*\(.*\)/\1/p')")"
export BAT_ARR=('󰂎' '󰁺' '󰁻' '󰁼' '󰁽' '󰁾' '󰁿' '󰂀' '󰂁' '󰂂' '󰁹')

case $OUT in
    "discharging") echo -n "${BAT_ARR[$((VAL / 10))]}";;
    "pending-charge") echo -n '󰂑';;
    "charging") echo -n "󱐋${BAT_ARR[$((VAL / 10))]}";;
    "fully-charged") echo -n '󱟢';;
    *) [ -n "$VAL" ] && echo 'none';;
esac

[ -n "$VAL" ] && echo " $VAL%"
