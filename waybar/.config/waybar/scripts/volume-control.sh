#!/usr/bin/env bash
# Define functions
print_error() {
  cat <<"EOF"
Usage: ./volume-control.sh -[device] <actions>
...valid devices are...
    i   -- input device
    o   -- output device
    p   -- player application
...valid actions are...
    i   -- increase volume [+2]
    d   -- decrease volume [-2]
    m   -- mute [x]
EOF
  exit 1
}

icon() {
  vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's/^Volume: //' | grep -Eo '[0-9]+\.[0-9]+' | awk '{print int($1*100)}')
  mute=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o MUTED)
  if [ -n "$mute" ] || [ "$vol" -eq 0 ]; then
    icon="volume-level-muted"
  elif [ "$vol" -lt 33 ]; then
    icon="volume-level-low"
  elif [ "$vol" -lt 66 ]; then
    icon="volume-level-medium"
  else
    icon="volume-level-high"
  fi
}

send_notification() {
  icon
  notify-send -a "state" -r 91190 -i "$icon" -h int:value:"$vol" "Volume: ${vol}%" -u low
}

#notify_mute() {
#  mute=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o MUTED)
#  if [ -n "$mute" ]; then
#    notify-send -a "state" -r 91190 -i "volume-level-muted" "Volume: Muted" -u low
#  else
#    icon
#    notify-send -a "state" -r 91190 -i "$icon" "Volume: Unmuted" -u low
#  fi
#}

action_volume() {
  case "${1}" in
  i)
    # Increase volume if below 100
    current_vol=$(wpctl get-volume "$device_type" | sed 's/^Volume: //' | grep -Eo '[0-9]+\.[0-9]+' | awk '{print int($1*100)}')
    if [ "$current_vol" -lt 100 ]; then
      wpctl set-volume -l 1.0 "$device_type" 2%+
    fi
    ;;
  d)
    # Decrease volume if above 0
    wpctl set-volume "$device_type" 2%-
    ;;
  esac
}


select_output() {
  if [ "$@" ]; then
    desc="$*"
    # Get list of sinks and their IDs
    sinks=$(wpctl status | awk '/Audio Sink/,/Audio Source/' | grep -oP '^\s*\d+\.\s.*')

    # Try to find matching sink
    sink_id=$(echo "$sinks" | grep -F "$desc" | awk '{print $1}' | tr -d '.')

    if [ -n "$sink_id" ]; then
      wpctl set-default @${sink_id}@
      notify-send -r 91190 "Activated: $desc"
    else
      notify-send -r 91190 "Error activating $desc"
    fi
  else
    # List available sinks
    wpctl status | awk '/Audio Sink/,/Audio Source/' | grep -oP '(?<=\]\s).*'
  fi
}

# Evaluate device option
while getopts ":iop:s::" DeviceOpt; do
  case "${DeviceOpt}" in
  i)
    nsink=$(wpctl status | grep -A 20 "Audio Source" | grep -c '\[')
    [ "$nsink" -eq 0 ] && echo "ERROR: Input device not found..." && exit 0
    device_type="@DEFAULT_AUDIO_SOURCE@"
    ;;
  o)
    nsink=$(wpctl status | grep -A 20 "Audio Sink" | grep -c '\[')
    [ "$nsink" -eq 0 ] && echo "ERROR: Output device not found..." && exit 0
    device_type="@DEFAULT_AUDIO_SINK@"
    ;;
  p)
    # Note: playerctl is a separate program that may work as-is
    nsink=$(playerctl --list-all | grep -w "${OPTARG}")
    [ -z "${nsink}" ] && echo "ERROR: Player ${OPTARG} not active..." && exit 0
    # shellcheck disable=SC2034
    device_type="${nsink}"
    ;;
s)
  if [ -n "$OPTARG" ]; then
    select_output "$OPTARG"
  else
    select_output
  fi
  exit
  ;;
  *) print_error ;;
  esac
done

# Set default variables if not specified
if [ -z "$device_type" ]; then
  device_type="@DEFAULT_AUDIO_SINK@"
fi

shift $((OPTIND - 1))

# Execute action
case "${1}" in
i) action_volume i ;;
d) action_volume d ;;
m) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && exit 0 ;;
*) print_error ;;
esac

#send_notification
