#!/usr/bin/env bash

continue=1

FILE="$HOME/.config/polybar/scripts/eth_monitoring"
## Select the interface to monitor
select_interface() {
	ifnames=$(ip link | awk -F: '$2 ~ /eno|enp|enx|eth/{print $2}')
	count=0
	if [ -e "$FILE" ]; then
		iface_in_file=$(cat "$FILE")
	fi
	while IFS= read -r ifname; do
		if [ "$ifname" = "$iface_in_file" ]; then
			current_selected_interface=$count
		fi
		((count++))
	done <<< "$ifnames"
	echo "$value"
	if [ ! -z "$ifnames" ]; then
		# Display the rofi menu with all the sinks available
		chosen_interface="$(echo -e "$ifnames" | rofi -dmenu -p "[Network] Select the interface to monitor" -l $count -a $current_selected_interface )"
		# If cancel (escape key) nothing to do
		if [ -z "$chosen_interface" ]; then
			exit 1
		fi
		echo "$chosen_interface" > $FILE
	fi
}

## Display the IP address for the selected interface
monitor_interface() {
	if [ ! -e "$FILE" ]; then
		echo "%{u#fb4934}%{+u}Select an eth interface to monitor%{u-}"
	else
		# Remove trailing whitespace
		ifname=$(cat "$FILE" | sed -e 's/^[ \t]*//')
		ls /sys/class/net/"$ifname"/carrier &> /dev/null
		if (( $? != 0 )); then
			echo "%{u#fb4934}%{+u} No $ifname iface found%{u-}"
		else
			link=$(cat /sys/class/net/"$ifname"/carrier)
			if (( $link == 0 )); then
				echo "%{u#fb4934}%{+u} cable unplugged%{u-}"
				continue=0
			else
				eth_ip=$(ip addr show $ifname | awk '$1 ~ /^inet$/ {printf "%s\n", $2}' | sed 's/\/.*//'| awk '$1 !~ /127.0.0.1$/ {printf "%s\n", $1}')
				if [ -z $eth_ip ]; then
					echo "%{u#fb4934}%{+u} No IP%{u-}"
					continue=0
				fi
			fi

			if [ "$continue" = 1 ]; then
				if [ -z "$eth_ip" ]; then
					echo "%{u#fb4934}%{+u}%{u-}"
				else
					ping_cmd=$(ping -I $ifname -c3 8.8.8.8 2> /dev/null)
					if [ $? -ne 0 ]; then
						echo "%{u#fe8019}%{+u} $eth_ip [ping error]%{u-}"
						exit
					fi
					ping=$(echo "$ping_cmd" | awk '/transmitted/' | sed -e 's/.*, \(.*\)packet loss.*/\1/' | tr -d '%')
					# Convert float to int
					ping=${ping%.*}
					if (( $ping == 100 )); then
						# All packets lost
						echo "%{u#fb4934}%{+u} $eth_ip%{u-}"
					elif (( $ping > 0 )); then
						# Some packets lost
						echo "%{u#fe8019}%{+u} $eth_ip%{u-}"
					else
						# All packets received
						echo "%{u#b8bb26}%{+u} $eth_ip%{u-}"
					fi
				fi
			fi
		fi
	fi
}

while getopts "sm" option; do
	case "${option}" in
		s) # Select the interface to monitor
			select_interface
			;;
		m) # Monitor the selected interface
			monitor_interface
			;;
		*) # incorrect option
			echo "Error: Invalid option $option"
			;;
    esac
done
