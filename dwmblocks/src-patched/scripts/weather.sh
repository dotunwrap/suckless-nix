#!/usr/bin/env bash

GEO_INFO=$(curl -s "https://json.geoiplookup.io")
LAT=$(echo "$GEO_INFO" | jq -r '.latitude')
LON=$(echo "$GEO_INFO" | jq -r '.longitude')

ICON="󰅟"
WEATHER_INFO=$(curl -s "https://api.weather.gov/points/$LAT,$LON" |
  jq -r '.properties.forecastHourly' |
  xargs -I {} curl -s {} |
  jq -r '
    .properties.periods[0] |
    ((.temperature - 32) * 5 / 9 | floor | tostring) + "°C, " +
    .shortForecast
  ')

echo "$ICON $WEATHER_INFO"
