#!/bin/sh
power_bat0=$( cat /sys/class/power_supply/BAT0/power_now )
status_bat0=$( cat /sys/class/power_supply/BAT0/status )


if [ -d "/sys/class/power_supply/BAT1" ]
then
power_bat1=$( cat /sys/class/power_supply/BAT1/power_now )
status_bat1=$( cat /sys/class/power_supply/BAT1/status )
else
power_bat1=0
status_bat1="Unknown"
fi

old_energy=$( cat /sys/class/powercap/intel-rapl:0/energy_uj )

power_total=$(((power_bat0+power_bat1)/1000000))

if [ $status_bat0 = 'Charging' ] || [ $status_bat1 = 'Charging' ]
then
sign="+"
else
sign="-"
fi

power_total="${sign}${power_total}W"

if [ $status_bat0 = 'Unknown' ] && [ $status_bat1 = 'Unknown' ]
then
sleep 1
current_energy=$( cat /sys/class/powercap/intel-rapl:0/energy_uj )
power_total="$(((current_energy-old_energy)/1000000))W"
fi


echo $power_total