#!/bin/sh

zipFile=$1

# Initialize recoveryfs image global variables
recoveryfs_partition="/dev/block/bootdevice/by-name/recoveryfs"
recovery_partition="/dev/block/bootdevice/by-name/recovery"

# Initialize upgrade package global variables
recoveryimg="recoveryupgrade/recovery.img"
recoveryfsimg="recoveryupgrade/recoveryfs-unsparsed.img"


################################################################################
# Helper functions

# Unzip 'file' file from 'zip' zipFile and write the contents to 'partition'.
# Terminates the program if any of the operations within encountered errors.
UpgradePartitionWithImage() {
    partition=$1
    file=$2

    # Use unzip to update the partition with the input image
    unzip -p $zipFile $file > $partition || exit 1
}

PartitionGetSHA1Sum() {
    partition=$1
    length=$2

    head -c $length $partition  | sha1sum | awk '{ print $1 }'
}

UnzipAndGetLength() {
    file=$1

    unzip -l $zipFile $file | tail -1 | xargs | cut -d ' ' -f1 | tr -d '\n ' 
}

UnzipAndGetSHA1Sum() {
    file=$1

    unzip -p $zipFile $file | sha1sum | awk '{ print $1 }' | tr -d '\n '
}

UpdateImage() {
    partition=$1
    image=$2

    echo "Calculating $image length..."
    zipImageLength=$(UnzipAndGetLength $image)
    if [ ! "$zipImageLength" -gt 0 ]
    then
        echo "Invalid length, $zipImageLength, for image: $image!"
        echo "Assuming image doesn't exist..."
        return
    fi
    echo "$image length is:  $zipImageLength"

    echo "Calculating $image SHA1Sum..."
    zipImageSHA1Sum=$(UnzipAndGetSHA1Sum $image)
    echo "$image SHA1Sum is: $zipImageSHA1Sum"

    echo "Calculating $partition SHA1Sum..."
    if [ ! -L "$partition" ]
    then
        echo "No partition $partition!"
        exit 1
    fi

    echo "Updating $partition with $image"
    UpgradePartitionWithImage $partition $image

    echo "Calculating new SHA1Sum of $partition"
    partitionSHA1Sum=$(PartitionGetSHA1Sum $partition $zipImageLength)
    echo "New SHA1Sum of $partition is: $partitionSHA1Sum"
    if [ "$zipImageSHA1Sum" != "$partitionSHA1Sum" ]
    then
        echo "Hashes do no match!"
        echo "Updating $partition with $image failed!"
        exit 1
    fi
}

# End of Helper functions
################################################################################


if [ ! -f "$zipFile" ]
then
    echo "Invalid update zip file given! Exiting..."
    exit 1
fi

UpdateImage $recovery_partition $recoveryimg
UpdateImage $recoveryfs_partition $recoveryfsimg

exit 0

