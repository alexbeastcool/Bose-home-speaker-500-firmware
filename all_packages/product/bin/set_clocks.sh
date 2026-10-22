#!/bin/bash
# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
# level options : interactive conservative ondemand userspace powersave performance
LEVEL=$1
# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
# speed options :  400000 960000 1094400 1248000 1401000
SPEED=$2
MAX_CORE=3      # Number of cores - 1
if [ ${LEVEL} == "userspace" ]; then
    if [ ${SPEED} == "" ]; then
        echo "Must specify a speed after 'userpsace'"
        exit 1
    fi
    echo "Setting custom frequency ${SPEED}"
else
    echo "Setting CPU governor to ${LEVEL}"
fi
for i in `seq 0 ${MAX_CORE}`; do
    echo "${LEVEL}" > /sys/devices/system/cpu/cpu${i}/cpufreq/scaling_governor
done
if [ ${LEVEL} == "userspace" ]; then
    for i in `seq 0 ${MAX_CORE}`; do
        echo "${SPEED}" > /sys/devices/system/cpu/cpu${i}/cpufreq/scaling_setspeed
    done
fi
echo "Speeds are now:"
for i in `seq 0 ${MAX_CORE}`; do
    echo "    Core ${i}: `cat /sys/devices/system/cpu/cpu${i}/cpufreq/cpuinfo_cur_freq`"
done
