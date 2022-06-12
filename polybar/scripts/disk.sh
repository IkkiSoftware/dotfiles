#!/usr/bin/env bash
hdd_state=0
for partition in "$@"; do
    infos=$(df -h $partition --output=size,used,pcent | awk 'NR==2{printf "%s/%s (%s)\n", $2,$1,$3 }')
    hdd_percent=$(echo "$infos" | awk '{print $2}' | tr -d '(%)')
	if (( $hdd_percent >= 70 && $hdd_percent < 90 )); then
		hdd_state=1
	elif (( $hdd_percent >= 90 )); then
		hdd_state=2
    fi
    output="$output [$partition] $infos"
done
if [ $hdd_state -eq 1 ]; then
	echo "%{u#fe8019}%{+u} $output%{u-}"
elif [ $hdd_state -eq 2 ]; then
	echo "%{u#fb4934}%{+u} $output%{u-}"
else
	echo "%{u#b8bb26}%{+u} $output%{u-}"
fi
