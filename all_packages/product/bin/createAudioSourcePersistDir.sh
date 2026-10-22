#!/bin/bash
# This handles directory creation for all Audio Source 
# This Changes came into picture after CASTLE-53906: Privileage Separation of Process
# After This change the perticular owner only have permission to that(700 permission)
# For Riviera everthing is root but in case of Coronado all process is non root
# and started by perticular users.
mkdir -pm 700 /mnt/nv/product-persistence/ALEXA
mkdir -pm 700 /mnt/nv/product-persistence/SPOTIFY
mkdir -pm 700 /mnt/nv/product-persistence/CHROMECASTBUILTIN
mkdir -pm 700 /mnt/nv/product-persistence/AIRPLAY
mkdir -pm 700 /mnt/nv/product-persistence/BLUETOOTH
mkdir -pm 700 /mnt/nv/product-persistence/PANDORA
mkdir -pm 700 /mnt/nv/product-persistence/Deezer
mkdir -pm 700 /mnt/nv/product-persistence/IHEART
mkdir -pm 700 /mnt/nv/product-persistence/SIRIUSXM
mkdir -pm 700 /mnt/nv/product-persistence/QQMUSIC
mkdir -pm 700 /mnt/nv/product-persistence/Amazon
mkdir -pm 700 /mnt/nv/product-persistence/GVA
mkdir -pm 700 /mnt/nv/product-persistence/UPNP
mkdir -pm 700 /mnt/nv/product-persistence/QPLAY
mkdir -pm 700 /mnt/nv/product-persistence/TUNEIN

if id -u "avs" >/dev/null 2>&1; then
    #here onlt avs user will have access to this folder
    chown avs:avs -R /mnt/nv/product-persistence/ALEXA
fi
if id -u "spotify" >/dev/null 2>&1; then
    #here onlt spotify user will have access to this folder
    chown spotify:spotify -R /mnt/nv/product-persistence/SPOTIFY
fi
if id -u "cast" >/dev/null 2>&1; then
    #here onlt cast user will have access to this folder
    chown cast:cast -R /mnt/nv/product-persistence/CHROMECASTBUILTIN
fi
if id -u "airplay" >/dev/null 2>&1; then
    #here onlt airplay user will have access to this folder
    chown airplay:airplay -R /mnt/nv/product-persistence/AIRPLAY
fi
if [[ $(id -u "bose" 2>/dev/null) && $(cat /sys/devices/soc0/machine) == QCS405 ]]
then
    #here onlt bose user will have access to this folder
    chown bose:bose -R /mnt/nv/product-persistence/BLUETOOTH
    chown bose:bose -R /mnt/nv/product-persistence/PANDORA
    chown bose:bose -R /mnt/nv/product-persistence/Deezer
    chown bose:bose -R /mnt/nv/product-persistence/IHEART
    chown bose:bose -R /mnt/nv/product-persistence/SIRIUSXM
    chown bose:bose -R /mnt/nv/product-persistence/QQMUSIC
    chown bose:bose -R /mnt/nv/product-persistence/Amazon
    chown bose:bose -R /mnt/nv/product-persistence/GVA
    chown bose:bose -R /mnt/nv/product-persistence/UPNP
    chown bose:bose -R /mnt/nv/product-persistence/QPLAY
    chown bose:bose -R /mnt/nv/product-persistence/TUNEIN
fi
