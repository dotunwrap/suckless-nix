#!/usr/bin/env bash

# Usage: weather.sh LAT LON
LAT="35.4961"
LON="-80.6263"

curl -s "https://api.weather.gov/points/$LAT,$LON" \
  | jq -r '.properties.forecastHourly' \
  | xargs -I {} curl -s {} \
  | jq -r '
    .properties.periods[0] |
    ((.temperature - 32) * 5 / 9 | floor | tostring) + "°C, " +
    .shortForecast
  '
