get_wifi() {
  local iface essid raw pct wifi_ico
  iface=$(ip link | awk -F: '/wlp|wl|wlan/ {gsub(/ /,"",$2); print $2; exit}')

  if [ -z "$iface" ]; then
    echo "󰖪  No Hardware"
    return
  fi

  essid=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes:' | cut -d: -f2 2>/dev/null)
  if [ -z "$essid" ]; then
    echo "󰤮  Disconnected"
    return
  fi

  raw=$(awk -v f="$iface" '$1~f {print int($3)}' /proc/net/wireless 2>/dev/null)
  pct=0
  if [ -n "$raw" ]; then
    pct=$(( raw * 100 / 70 ))
  fi

  if [ "$pct" -ge 75 ]; then wifi_ico="󰤨 "
  elif [ "$pct" -ge 50 ]; then wifi_ico="󰤥 "
  elif [ "$pct" -ge 25 ]; then wifi_ico="󰤢 "
  else wifi_ico="󰤟 "; fi

  echo "$wifi_ico  $essid ($pct%)"
}
