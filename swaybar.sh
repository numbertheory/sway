#!/bin/sh

# ==============================================================================
# MODULE FUNCTIONS
# ==============================================================================
MODULES_DIR="$(dirname "$(readlink -f "$0")")/modules"
. "$MODULES_DIR/sway_get_wifi.sh"
. "$MODULES_DIR/sway_get_battery.sh"
. "$MODULES_DIR/sway_get_volume.sh"
. "$MODULES_DIR/sway_get_bluetooth.sh"
. "$MODULES_DIR/sway_get_date.sh"

exec swayidle -w \
  before-sleep 'swaylock -f' \
  timeout 300 'swaylock -f'


# ==============================================================================
# MAIN STATUS BAR LOOP
# ==============================================================================
while true; do
  # Call functions (now natively available in shell memory)
  wifi_str=$(get_wifi)
  bat_str=$(get_battery)
  vol_str=$(get_volume)
  bt_str=$(get_bluetooth)
  date_str=$(get_date)

  # Build the Layout String Dynamically
  OUTPUT=""
  for item in "$bt_str" "$vol_str" "$bat_str" "$wifi_str"; do
    if [ -n "$item" ]; then
      if [ -z "$OUTPUT" ]; then
        OUTPUT="$item"
      else
        OUTPUT="$OUTPUT  |  $item"
      fi
    fi
  done

  if [ -n "$OUTPUT" ]; then
    echo "$OUTPUT  |  $date_str"
  else
    echo "$date_str"
  fi

  sleep 2
done
