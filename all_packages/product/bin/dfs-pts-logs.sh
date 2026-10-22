#!/bin/bash
#
# An arbitrary collection of system logs to be
# delivered via the /logread.txt endpoint of the PtsServer.
#
# Not really needed since this script is called programatically.
#if (( $# > 0 )); then
#    echo >&2 "$0: unexpected argument '$1'"
#    exit 1
#fi



logread
#dmesg does not work because of a permissions issue
#see sysctl -a

if [ -f "/etc/riviera-version" ]; 
then
    printf "\n\f\n> dmesg\n"
    dmesg
else
    printf "\n\dmmesg not permitted on non-Riviera systems"
fi


printf "\n\f\n> dmesg\n"

for i in /opt/Bose/pts/logs.d/*; do
    if [ -x "$i" ]; then
        printf "\n\f\n> %s\n" "$i"
        "$i"
    fi
done

printf "\n\f\n"

#This used to hang.
dfs-pts-info.sh

