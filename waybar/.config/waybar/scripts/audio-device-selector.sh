#!/usr/bin/env bash

# audio-decive-selector.sh

# Rofi config
config="$HOME/.config/rofi/audio-output-menu.rasi"

# Get short list of sinks
sink_info=$(pactl list short sinks)

# Get the name of the active sink
active_sink=$(pactl info | grep "Default Sink" | awk '{print $3}')

# Build display list
menu=""
mapfile -t sink_lines <<< "$sink_info"

for line in "${sink_lines[@]}"; do
    IFS=$'\t' read -r index name state <<< "$line"
    description=$(pactl list sinks | grep -A20 "$name" | grep "Description:" | head -n1 | sed 's/.*Description: //')
   
	if [[ "$name" == "$active_sink" ]]; then
        	menu+="${description} (active)\n"
    	else
        	menu+="${description}\n"
    	fi
done

# Display menu using Rofi (no input field)
selected=$(echo -e "$menu" | rofi -dmenu -config "$config" -theme-str 'entry { placeholder: ""; } listview { lines: 5; fixed-height: true; }' -p "󰕾 Audio Output")

# If selection made, set sink
if [[ -n "$selected" ]]; then
    for line in "${sink_lines[@]}"; do
        IFS=$'\t' read -r index name state <<< "$line"
        desc=$(pactl list sinks | grep -A20 "$name" | grep "Description:" | head -n1 | sed 's/.*Description: //')
        if [[ "$desc" == "$selected" ]]; then
            pactl set-default-sink "$name" &&
                notify-send "󰕾 Audio output changed" "$selected"
            break
        fi
    done
fi
