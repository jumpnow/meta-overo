#!/bin/bash

MACHINE=overo

if [ "x${1}" = "x" ]; then
    echo "Usage: ${0} <block device>"
    exit 0
fi

mount | grep '^/' | grep -q ${1}

if [ $? -ne 1 ]; then
    echo "Looks like partitions on device /dev/${1} are mounted"
    echo "Not going to work on a device that is currently in use"
    mount | grep ${1}
    exit 1
fi

if [ ! -d /media/card ]; then
    echo "Temporary mount point [/media/card] not found"
    exit 1
fi

if [ -z "$OETMP" ]; then
   # echo try to find it
    if [ -f ../../build/conf/local.conf ]; then
        OETMP=$(grep '^TMPDIR' ../../build/conf/local.conf | awk '{ print $3 }' | sed 's/"//g')

        if [ -z "$OETMP" ]; then
            OETMP=../../build/tmp
        fi
    fi
fi


echo "OETMP: $OETMP"

if [ ! -d ${OETMP}/deploy/images/${MACHINE} ]; then
    echo "Directory not found: ${OETMP}/deploy/images/${MACHINE}"
    exit 1
fi

SRC=${OETMP}/deploy/images/${MACHINE}

if [ ! -f ${SRC}/MLO-${MACHINE} ]; then
    echo "File not found: ${SRC}/MLO-${MACHINE}"
    exit 1
fi

if [ ! -f ${SRC}/u-boot-${MACHINE}.img ]; then
    echo "File not found: ${SRC}/u-boot-${MACHINE}.img"
    exit 1
fi

if [ ! -f ${SRC}/boot.scr ]; then
    echo "File not found: ${SRC}/boot.scr"
    exit 1
fi

if [ -b ${1} ]; then
    DEV=${1}
elif [ -b "/dev/${1}1" ]; then
    DEV=/dev/${1}1
elif [ -b "/dev/${1}p1" ]; then
    DEV=/dev/${1}p1
else
    echo "Block device not found: /dev/${1}1 or /dev/${1}p1"
    exit 1
fi

echo "Formatting FAT partition on $DEV"
sudo mkfs.vfat ${DEV} -n "BOOT"

echo "Mounting $DEV"
sudo mount ${DEV} /media/card

echo "Copying MLO"
sudo cp ${SRC}/MLO-${MACHINE} /media/card/MLO

echo "Copying u-boot"
sudo cp ${SRC}/u-boot-${MACHINE}.img /media/card/u-boot.img

echo "Copying boot.scr"
sudo cp ${SRC}/boot.scr /media/card

sudo sync

echo "Unmounting ${DEV}"
sudo umount ${DEV}

echo "Done"
