get_bluetooth() {
  local bt_devices bt_name bt_bat
  bt_devices=$(bluetoothctl devices Connected 2>/dev/null)

  if [ -z "$bt_devices" ]; then
    echo "" # Hidden when completely disconnected
    return
  fi

  bt_name=$(echo "$bt_devices" | cut -d' ' -f3-)
  bt_bat=$(bluetoothctl info | grep "Battery Percentage" | awk -F '[()]' '{print $2}')

  if [ -n "$bt_bat" ]; then
    # Filter non-digits from the battery value just in case to safely compare integers
    local bt_bat_num=$(echo "$bt_bat" | tr -cd '0-9')

    # Only append the battery info if it is 20% or lower
    if [ -n "$bt_bat_num" ] && [ "$bt_bat_num" -le 20 ]; then
      echo "󰋋  $bt_name ($bt_bat_num%)"
    else
      echo "󰋋  $bt_name" # Hide battery, but keep showing the device name
    fi
  else
    echo "󰋋  $bt_name"
  fi
}
