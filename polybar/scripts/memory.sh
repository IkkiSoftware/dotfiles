#!/usr/bin/env bash
memory=$(free -m | awk 'NR==2{printf("%s/%s MB (%.2f%%)\n", $3,$2,$3*100/$2)}')
memory_percent=$(echo $memory | sed -e 's/.*(\(.*\))/\1/')
memory_percent=${memory_percent%.*}
swap=$(free -m | awk 'NR==3{printf("%s/%s MB (%.2f%%)\n", $3,$2,$3*100/$2)}')
swap_percent=$(echo $swap | sed -e 's/.*(\(.*\))/\1/')
swap_percent=${swap_percent%.*}
if (( $swap_percent > 5 || $memory_percent > 80 )); then
	echo "%{u#fb4934}%{+u} $memory - SWAP $swap%{u-}"
elif (( $memory_percent > 65 )); then
	echo "%{u#fe8019}%{+u} $memory - SWAP $swap%{u-}"
else
	echo "%{u#b8bb26}%{+u} $memory - SWAP $swap%{u-}"
fi
