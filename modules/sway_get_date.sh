get_date() {
  local time_12h
  time_12h=$(date +'%-I:%M %p' | tr 'A-Z' 'a-z')
  echo "$(date +'%F') | $time_12h"
}
