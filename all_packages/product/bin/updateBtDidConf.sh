#!/bin/bash

# only fail ipk if development flag is set
development=$(jq -r .development /persist/mfg_data.json)
if [ "$development" != "true" ]; then
    development=false
fi

cp /opt/Bose/etc/bt_did.conf /mnt/nv/product-persistence/

baseFile="/mnt/nv/product-persistence/bt_did.conf"
if [ ! -f "$baseFile" ]; then
    if $development; then
        echo >&2 "$0: bt_did.conf does not exist"; exit 1;
    fi
fi

bmapID=$(jq -r .BMAPProductID /persist/mfg_data.json)
if [ $? -ne 0 ] || [ "$bmapID" == "null" ]; then
    if $development; then
        echo >&2 "$0: Failed to read BMAPProductID from mfg_data.json"; exit 1;
    fi
fi
echo "BMAPProductID is $bmapID"

majorVer=$(jq -r .major /opt/Bose/etc/BoseVersion.json)
if [ $? -ne 0 ] || [ "$majorVer" == "null" ]; then
    if $development; then
        echo >&2 "$0: Failed to read major version from mfg_data.json"; exit 1;
    fi
else
    #limited to 2 bytes in fluoride
    if (( $majorVer > 255 )); then
        if $development; then
            echo >&2 "$0: Major version is >256, but we only have two bytes for field"; exit 1;
        else
            majorVer="255"
        fi
    fi

fi
echo "MajorVersion is $majorVer"

#convert majorVer to hex
hexVersion=$(printf '0x%02x00' "$majorVer")
if [ $? -ne 0 ]; then
    if $development; then
        echo >&2 "$0: Failed to CONVERT major version from mfg_data.json"; exit 1;
    fi
fi
echo "hexVersion is $hexVersion"

sed -i "s/^productId = 0x0000/productId = $bmapID/" "$baseFile"
if [ $? -ne 0 ]; then
    if $development; then
        echo >&2 "$0: Failed to write BMAPProductID to bt_did.conf"; exit 1;
    fi
fi

sed -i "s/^version = 0x0000/version = $hexVersion/" "$baseFile"
if [ $? -ne 0 ]; then
    if $development; then
        echo >&2 "$0: Failed to write version to bt_did.conf"; exit 1;
    fi
fi
