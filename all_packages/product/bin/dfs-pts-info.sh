#!/bin/bash
#
# An arbitrary collection of system status information to be
# delivered via the /pts.txt endpoint of the PtsServer.
#

if (( $# > 0 )); then
    echo >&2 "$0: unexpected argument '$1'"
    exit 1
fi
exec 2>&1 # stderr goes to stdout

(
PS4='> '; set -x

md5sum /opt/Bose/etc/secure/publicKeys/bose_public_key_swupdate.pem
get-pubkey-type

if [ -f "/etc/riviera-version" ]; then
    cat /etc/riviera-version
elif [ -f "/etc/coronado-version" ]; then
    cat /etc/coronado-version
fi

ifconfig -a
ip route list
wpa_cli status
wpa_cli scan_results
ReadLpmVersion blob user-app boot-loader psoc lightbar-anim-db dsp darr
head -20 /mnt/nv/product-persistence/*
ls -lHt /mnt/nv/BoseLog
ps
printenv
jq . /mnt/nv/update/telemetry.json
jq . /mnt/nv/updateSwUpComponentStatus.dat
ls -lHt /opt/Bose/.swUpdateCache/ipks
ls -lHt /opt/Bose/.swUpdateCache/localupdate
tap-command 'lpm pt "lb history"'
tap-command 'lpm pt "vr"'
tap-command getpdo system
tap-command product boot_status
tap-command product chimes history
tap-command product get_clock
tap-command product settings all
tap-command product software_update_status
tap-command product state
tap-command product timer_status
tap-command product trace_hsm
tap-command network status
tap-command network wifi profiles info
tap-command network wifi status
tap-command galapagos status
tap-command galapagos discovery response
tap-command softwareupdate state
tap-command softwareupdate history
tap-command softwareupdate update history
tap-command softwareupdate list
tap-command qss get_src_list
tap-command qss get_src_cfg
tap-command qss list_codesets

tap-command 'lpm pt "cec la"'
tap-command 'lpm pt "acc"'

# DARR Band Settings
tap-command 'lpm pt "wa x,s"'

#DeviceController Config
cat /mnt/nv/product-persistence/DeviceControllerConfig.dat

tap-command vpa getvoicesettings
tap-command vpa getactivevpa
tap-command vpa getstate

)

#for i in /opt/Bose/pts/info.d/*; do
#    if [ -x "$i" ]; then
#        echo "> $i"
#        "$i"
#    fi
#done

