#!/usr/bin/env bash
while :; do
	# Get the first line with aggregate of all CPUs
	cpu_now=($(head -n1 /proc/stat))
	# Get all columns but skip the first (which is the "cpu" string)
	cpu_sum="${cpu_now[@]:1}"
	# Replace the column seperator (space) with +
	cpu_sum=$((${cpu_sum// /+}))
	# Get the delta between two reads
	cpu_delta=$((cpu_sum - cpu_last_sum))
	# Get the idle time Delta
	cpu_idle=$((cpu_now[4]- cpu_last[4]))
	# Calc time spent working
	cpu_used=$((cpu_delta - cpu_idle))
	# Calc percentage
	cpu_usage=$((100 * cpu_used / cpu_delta))

	# Keep this as last for our next read
	cpu_last=("${cpu_now[@]}")
	cpu_last_sum=$cpu_sum

	if (( $cpu_usage > 80 )); then
		echo "%{u#fb4934}%{+u} $cpu_usage%%{u-}"
	elif (( $cpu_usage > 60 )); then
		echo "%{u#fe8019}%{+u} $cpu_usage%%{u-}"
	else
		if [[ ${#cpu_usage} < 2 ]]; then
			echo "%{u#b8bb26}%{+u} 0$cpu_usage%%{u-}"
		else
			echo "%{u#b8bb26}%{+u} $cpu_usage%%{u-}"
		fi
	fi

	# Wait a second before the next read
	sleep 3
done

