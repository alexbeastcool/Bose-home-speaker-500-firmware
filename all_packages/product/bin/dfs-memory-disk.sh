#!/bin/bash
echo "free:"
free
printf "\n"
echo "disk free:"
df -ahT
printf "\n"
echo "/proc/meminfo:"
cat /proc/meminfo

