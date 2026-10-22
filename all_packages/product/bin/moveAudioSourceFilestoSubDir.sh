#!/bin/bash
# This Changes came into picture after CASTLE-53906: Privileage Separation of Process
# Due to this changes All Content of end customer need to move to AudioSource sub directories
# This script will be called During OTA update during post installation of Product IPK
mv /mnt/nv/product-persistence/*ALEXA* /mnt/nv/product-persistence/ALEXA
mv /mnt/nv/product-persistence/*AVS* /mnt/nv/product-persistence/ALEXA
mv /mnt/nv/product-persistence/*SPOTIFY* /mnt/nv/product-persistence/SPOTIFY
mv /mnt/nv/product-persistence/*CHROMECASTBUILTIN* /mnt/nv/product-persistence/CHROMECASTBUILTIN
mv /mnt/nv/product-persistence/*GoogleCast* /mnt/nv/product-persistence/CHROMECASTBUILTIN
mv /mnt/nv/product-persistence/*AirPlay* /mnt/nv/product-persistence/AIRPLAY
mv /mnt/nv/product-persistence/*BLUETOOTH.*history*.xml /mnt/nv/product-persistence/BLUETOOTH
mv /mnt/nv/product-persistence/*BLUETOOTH.*skiplist*.xml /mnt/nv/product-persistence/BLUETOOTH
mv /mnt/nv/product-persistence/*PANDORA.*history*.xml /mnt/nv/product-persistence/PANDORA
mv /mnt/nv/product-persistence/*PANDORA.*skiplist*.xml /mnt/nv/product-persistence/PANDORA
mv /mnt/nv/product-persistence/*Deezer.*history*.xml /mnt/nv/product-persistence/Deezer
mv /mnt/nv/product-persistence/*Deezer.*skiplist*.xml /mnt/nv/product-persistence/Deezer
mv /mnt/nv/product-persistence/*IHEART.*history*.xml /mnt/nv/product-persistence/IHEART
mv /mnt/nv/product-persistence/*IHEART.*skiplist*.xml /mnt/nv/product-persistence/IHEART
mv /mnt/nv/product-persistence/*SIRIUSXM.*history*.xml /mnt/nv/product-persistence/SIRIUSXM
mv /mnt/nv/product-persistence/*SIRIUSXM.*skiplist*.xml /mnt/nv/product-persistence/SIRIUSXM
mv /mnt/nv/product-persistence/*Amazon.*history*.xml /mnt/nv/product-persistence/Amazon
mv /mnt/nv/product-persistence/*Amazon.*skiplist*.xml /mnt/nv/product-persistence/Amazon
mv /mnt/nv/product-persistence/*QQMUSIC.*history*.xml /mnt/nv/product-persistence/QQMUSIC
mv /mnt/nv/product-persistence/*QQMUSIC.*skiplist*.xml /mnt/nv/product-persistence/QQMUSIC
mv /mnt/nv/product-persistence/*GVA.*history*.xml /mnt/nv/product-persistence/GVA
mv /mnt/nv/product-persistence/*GVA.*skiplist*.xml /mnt/nv/product-persistence/GVA
mv /mnt/nv/product-persistence/*UPNP.*history*.xml /mnt/nv/product-persistence/UPNP
mv /mnt/nv/product-persistence/*UPNP.*skiplist*.xml /mnt/nv/product-persistence/UPNP
mv /mnt/nv/product-persistence/*QPLAY.*history*.xml /mnt/nv/product-persistence/QPLAY
mv /mnt/nv/product-persistence/*QPLAY.*skiplist*.xml /mnt/nv/product-persistence/QPLAY
mv /mnt/nv/product-persistence/*TUNEIN.*history*.xml /mnt/nv/product-persistence/TUNEIN
mv /mnt/nv/product-persistence/*TUNEIN.*skiplist*.xml /mnt/nv/product-persistence/TUNEIN
mv /mnt/nv/product-persistence/*SIRIUSXM.*history*.xml /mnt/nv/product-persistence/SIRIUSXM
mv /mnt/nv/product-persistence/*SIRIUSXM.*skiplist*.xml /mnt/nv/product-persistence/SIRIUSXM