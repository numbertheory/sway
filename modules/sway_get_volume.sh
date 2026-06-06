get_volume() {
  local vol_data vol_pct vol_mute vol_ico
  vol_data=$(amixer get Master | awk -F'[][]' '/Left:/ {print $2, $4}' 2>/dev/null)

  if [ -n "$vol_data" ]; then
    vol_pct=$(echo "$vol_data" | awk '{print int($1)}')
    vol_mute=$(echo "$vol_data" | awk '{print $2}')

    if [ "$vol_mute" = "off" ]; then
      echo "󰝟 Muted"
    else
      if [ "$vol_pct" -ge 70 ]; then vol_ico="󰕾"
      elif [ "$vol_pct" -ge 30 ]; then vol_ico="󰖀"
      elif [ "$vol_pct" -gt 0 ]; then vol_ico="󰕿"
      else vol_ico="󰝟"; fi
      echo "$vol_ico  $vol_pct%"
    fi
  else
    echo "󰝟 --%"
  fi
}
