get_battery() {
  local bat_pct bat_stat bat_ico
  if [ -d "/sys/class/power_supply/BAT1" ]; then
    bat_pct=$(cat /sys/class/power_supply/BAT1/capacity)
    bat_stat=$(cat /sys/class/power_supply/BAT1/status)

    if [ "$bat_stat" = "Charging" ] || [ "$bat_stat" = "Full" ]; then
      echo "󰂄 $bat_pct%"
    elif [ "$bat_pct" -le 100 ]; then
      if [ "$bat_pct" -le 10 ]; then bat_ico="󰂎"; else bat_ico="󰁼"; fi
      echo "$bat_ico $bat_pct%"
    else
      # Laptop battery is healthy and discharging -> Hide it on the bar
      echo ""
    fi
  else
    echo "󰂃 No Bat"
  fi
}
