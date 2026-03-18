#!/usr/bin/env bash

ICON_ARR=('󰖁' '' '󰖀' '󰕾')
AUDIO_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
VOL=$(echo "$AUDIO_INFO" | awk '{ printf "%d", $2 * 100 }')
ICON=${ICON_ARR[0]}

if echo "$AUDIO_INFO" | grep -q '\[MUTED\]'; then
  ICON=${ICON_ARR[1]}
elif [ "$VOL" -eq 0 ]; then
  ICON=${ICON_ARR[1]}
elif [ "$VOL" -le 49 ]; then
  ICON=${ICON_ARR[2]}
else
  ICON=${ICON_ARR[3]}
fi

echo "$ICON $VOL%"
