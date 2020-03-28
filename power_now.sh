#!/bin/sh
power_bat0=$( cat /sys/class/power_supply/BAT0/power_now )
power_bat1=$( cat /sys/class/power_supply/BAT1/power_now )

status_bat0=$( cat /sys/class/power_supply/BAT0/status )
status_bat1=$( cat /sys/class/power_supply/BAT1/status )

power_total=$(((power_bat0+power_bat1)/1000000))

if [ $status_bat0 = 'Charging' ] || [ $status_bat1 = 'Charging' ]
then
sign="+"
else
sign="-"
fi

power_total="${sign}${power_total}W"

echo $power_total