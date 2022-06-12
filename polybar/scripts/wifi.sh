#!/usr/bin/env bash

ifname=$(ip link | awk -F: '$2 ~ /wl/{print $2}')
if [ ! -z "$ifname" ]; then
	if ! command -v nmcli &> /dev/null; then
		echo "%{u#fb4934}%{+u}nmcli command not found%{u-}"
	else
		# Remove trailing whitespace
		ifname=$(echo "${ifname}" | sed -e 's/^[ \t]*//')
		link=$(cat /sys/class/net/"$ifname"/carrier)
		if (( $link == 0 )); then
			echo "%{u#fe8019}%{+u}睊  No SSID selected%{u-}"
		else
			ip=$(ip addr show $ifname | awk '$1 ~ /^inet$/ {printf "%s\n", $2}' | sed 's/\/.*//'| awk '$1 !~ /127.0.0.1$/ {printf "%s\n", $1}')
			if [ ! -z $ip ]; then
				ssid=$(nmcli -t -f active,ssid dev wifi | awk '/yes/ {print $1}' | awk -F ':' '{print $2}')
				ping_cmd=$(ping -I $ifname -c3 8.8.8.8 2> /dev/null)
				if [ $? -ne 0 ]; then
					echo "%{u#fe8019}%{+u}  $ssid - $ip [ping error]%{u-}"
					exit
				fi
				ping=$(echo "$ping_cmd" | awk '/transmitted/' | sed -e 's/.*, \(.*\)packet loss.*/\1/' | tr -d '%')
				# Convert float to int
				ping=${ping%.*}
				if (( $ping == 100 )); then
					# All packets lost
					echo "%{u#fb4934}%{+u}  $ssid - $ip%{u-}"
				elif (( $ping > 0 )); then
					# Some packets lost
					echo "%{u#fe8019}%{+u}  $ssid - $ip%{u-}"
				else
					# All packets received
					echo "%{u#b8bb26}%{+u}  $ssid - $ip%{u-}"
				fi
			else
				echo "%{u#fb4934}%{+u}睊  No IP%{u-}"
			fi
		fi
	fi
fi
