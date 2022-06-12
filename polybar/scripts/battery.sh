#!/usr/bin/env bash

ls /sys/class/power_supply/BAT0/capacity &> /dev/null
if (( $? == 0 )); then
	battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)
	battery_status=$(cat /sys/class/power_supply/BAT0/status)
	if [ $battery_status == "Full" ]; then
		echo "%{u#b8bb26}%{+u} $battery_capacity%%{u-}"
	elif [ $battery_status == "Discharging" ]; then
		if (( $battery_capacity >= 90  )); then
			echo "%{u#b8bb26}%{+u} $battery_capacity%%{u-}"
		elif (( $battery_capacity >= 80  )); then
			echo "%{u#b8bb26}%{+u} $battery_capacity%%{u-}"
		elif (( $battery_capacity >= 70  )); then
			echo "%{u#b8bb26}%{+u} $battery_capacity%%{u-}"
		elif (( $battery_capacity >= 60  )); then
			echo "%{u#b8bb26}%{+u} $battery_capacity%%{u-}"
		elif (( $battery_capacity >= 50  )); then
			echo "%{u#fe8019}%{+u} $battery_capacity%%{u-}"
		elif (( $battery_capacity >= 40  )); then
			echo "%{u#fe8019}%{+u} $battery_capacity%%{u-}"
		elif (( $battery_capacity >= 30  )); then
			echo "%{u#fe8019}%{+u} $battery_capacity%%{u-}"
		elif (( $battery_capacity >= 20  )); then
			echo "%{u#fb4934}%{+u} $battery_capacity%%{u-}"
		elif (( $battery_capacity < 20  )); then
			echo "%{u#fb4934}%{+u} $battery_capacity%%{u-}"
		fi
	else
		if (( $battery_capacity >= 90  )); then
			echo "%{u#b8bb26}%{+u} $battery_capacity%%{u-}"
		elif (( $battery_capacity >= 80  )); then
			echo "%{u#b8bb26}%{+u} $battery_capacity%%{u-}"
		elif (( $battery_capacity >= 70  )); then
			echo "%{u#b8bb26}%{+u} $battery_capacity%%{u-}"
		elif (( $battery_capacity >= 60  )); then
			echo "%{u#b8bb26}%{+u}$battery_capacity%%{u-}"
		elif (( $battery_capacity >= 50  )); then
			echo "%{u#fe8019}%{+u} $battery_capacity%%{u-}"
		elif (( $battery_capacity >= 40  )); then
			echo "%{u#fe8019}%{+u} $battery_capacity%%{u-}"
		elif (( $battery_capacity >= 30  )); then
			echo "%{u#fe8019}%{+u} $battery_capacity%%{u-}"
		elif (( $battery_capacity >= 20  )); then
			echo "%{u#fb4934}%{+u} $battery_capacity%%{u-}"
		elif (( $battery_capacity < 20  )); then
			echo "%{u#fb4934}%{+u} $battery_capacity%%{u-}"
		fi
	fi
fi
