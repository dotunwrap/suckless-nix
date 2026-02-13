WIFI_CONNECTED="󰖩"     # nf-md-wifi
WIFI_DISCONNECTED="󰖪"  # nf-md-wifi_off
ETHERNET_CONNECTED="󰈀" # nf-md-ethernet
NETWORK_OFF="󰯡"        # nf-md-network_off
VPN_CONNECTED="󰦝"      # nf-md-vpn

# Get network connectivity state using nmcli with multiline output
nmcli_output=$(nmcli --mode multiline general status)

# Parse the multiline output
connectivity=$(echo "$nmcli_output" | grep -i "^CONNECTIVITY:" | awk '{print $2}')
state=$(echo "$nmcli_output" | grep -i "^STATE:" | awk '{print $2}')
wifi_enabled=$(echo "$nmcli_output" | grep -i "^WIFI:" | awk '{print $2}')

# Get active connection details
active_connection=$(nmcli --terse --fields TYPE,STATE connection show --active | grep ":activated" | head -n1)
connection_type=$(echo "$active_connection" | cut -d: -f1)

# Determine the appropriate icon and status message
if [ "$state" = "connected" ] || [ "$connectivity" = "full" ] || [ "$connectivity" = "limited" ]; then
  case "$connection_type" in
  "802-11-wireless" | "wifi")
    # Get WiFi signal strength of the CONNECTED network (marked with asterisk)
    signal=$(nmcli --terse --fields IN-USE,ACTIVE,RATE device wifi list | grep "^\*" | cut -d: -f3)
    if [ "$signal" != "" ]; then
      icon="$WIFI_CONNECTED"
      status="$signal"
    else
      icon="$WIFI_CONNECTED"
    fi
    ;;
  "802-3-ethernet" | "ethernet")
    signal=$(nmcli --terse --fields IN-USE,ACTIVE,RATE device ethernet list | grep "^\*" | cut -d: -f3)
    if [ "$signal" != "" ]; then
      icon="$ETHERNET_CONNECTED"
      status="$signal"
    else
      icon="$ETHERNET_CONNECTED"
    fi
    ;;
  "vpn" | "wireguard")
    icon="$VPN_CONNECTED"
    ;;
  *)
    icon="$WIFI_CONNECTED"
    ;;
  esac
elif [ "$wifi_enabled" = "enabled" ]; then
  icon="$WIFI_DISCONNECTED"
else
  icon="$NETWORK_OFF"
fi

# Output the result
echo "${icon} ${status}"
