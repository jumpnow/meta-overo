#!/bin/bash

MACHINE=overo

if [ "x${1}" = "x" ]; then
    echo -e "\nUsage: ${0} <block device> [ <image-type> [<hostname>] ]\n"
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

if [ "x${2}" = "x" ]; then
    IMAGE=console
else
    IMAGE=${2}
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

echo -e "\nOETMP: $OETMP"

if [ ! -d ${OETMP}/deploy/images/${MACHINE} ]; then
    echo "Directory not found: ${OETMP}/deploy/images/${MACHINE}"
    exit 1
fi

SRC=${OETMP}/deploy/images/${MACHINE}

echo "IMAGE: $IMAGE"

if [ "x${3}" = "x" ]; then
    TARGET_HOSTNAME=$MACHINE
else
    TARGET_HOSTNAME=${3}
fi

echo "HOSTNAME: $TARGET_HOSTNAME"


if [ ! -f "${SRC}/${IMAGE}-image-${MACHINE}.tar.xz" ]; then
    echo "File not found: ${SRC}/${IMAGE}-image-${MACHINE}.tar.xz"
    exit 1
fi

if [ -b ${1} ]; then
    DEV=${1}
elif [ -b "/dev/${1}2" ]; then
    DEV=/dev/${1}2
elif [ -b "/dev/${1}p2" ]; then
    DEV=/dev/${1}p2
else
    echo "Block device not found: /dev/${1}2 or /dev/${1}p2"
    exit 1
fi

echo "Formatting $DEV as ext4"
sudo mkfs.ext4 -q -L ROOT $DEV

echo "Mounting $DEV"
sudo mount $DEV /media/card

echo "Extracting ${IMAGE}-image-${MACHINE}.tar.xz to /media/card"
sudo tar -C /media/card -xJf ${SRC}/${IMAGE}-image-${MACHINE}.tar.xz

echo "Generating a random-seed for urandom"
mkdir -p /media/card/var/lib/systemd
sudo dd if=/dev/urandom of=/media/card/var/lib/systemd/random-seed bs=512 count=1
sudo chmod 600 /media/card/var/lib/systemd/random-seed

echo "Writing ${TARGET_HOSTNAME} to /etc/hostname"
export TARGET_HOSTNAME
sudo -E bash -c 'echo ${TARGET_HOSTNAME} > /media/card/etc/hostname'

if [ -f ${SRC}/interfaces ]; then
    echo "Writing interfaces to /media/card/etc/network/"
    sudo cp ${SRC}/interfaces /media/card/etc/network/interfaces
elif [ -f ./interfaces ]; then
    echo "Writing ./interfaces to /media/card/etc/network/"
    sudo cp ./interfaces /media/card/etc/network/interfaces
fi

if [ -f ${SRC}/wpa_supplicant.conf ]; then
    echo "Writing wpa_supplicant.conf to /media/card/etc/"
    sudo cp ${SRC}/wpa_supplicant.conf /media/card/etc/wpa_supplicant.conf
elif [ -f ./wpa_supplicant.conf ]; then
    echo "Writing ./wpa_supplicant.conf to /media/card/etc/"
    sudo cp ./wpa_supplicant.conf /media/card/etc/wpa_supplicant.conf
fi

echo "Unmounting $DEV"
sudo umount $DEV

if [ -b "/dev/${1}5" ]; then
    DEV=/dev/${1}5
    echo "Formatting flags partition as FAT: ${DEV}"
    sudo mkfs.vfat ${DEV}
fi

if [ -b "/dev/${1}6" ]; then
    DEV=/dev/${1}6
    echo "Formatting opt partition as ext4: ${DEV}"
    sudo mkfs.ext4 -q -F ${DEV}
fi

echo "Done"
