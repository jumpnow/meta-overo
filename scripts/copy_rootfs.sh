#!/bin/bash

mnt=/mnt

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

if [ ! -d "$mnt" ]; then
    echo "Temporary mount point [ $mnt ] not found"
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

if [ ! -d "${OETMP}/deploy/images/${MACHINE}" ]; then
    echo "Directory not found: ${OETMP}/deploy/images/${MACHINE}"
    exit 1
fi

src=${OETMP}/deploy/images/${MACHINE}

echo "IMAGE: $IMAGE"

if [ "x${3}" = "x" ]; then
    target_hostname=$MACHINE
else
    target_hostname=${3}
fi

echo "HOSTNAME: $target_hostname"


if [ ! -f "${src}/${IMAGE}-image-${MACHINE}.rootfs.tar.xz" ]; then
    echo "File not found: ${src}/${IMAGE}-image-${MACHINE}.rootfs.tar.xz"
    exit 1
fi

if [ -b "$1" ]; then
    dev="$1"
elif [ -b "/dev/${1}2" ]; then
    dev="/dev/${1}2"
elif [ -b "/dev/${1}p2" ]; then
    dev="/dev/${1}p2"
else
    echo "Block device not found: /dev/${1}2 or /dev/${1}p2"
    exit 1
fi

echo "Formatting $dev as ext4"
sudo mkfs.ext4 -q -L ROOT "$dev"

echo "Mounting $dev"
sudo mount "$dev" "$mnt"

echo "Extracting ${IMAGE}-image-${MACHINE}.rootfs.tar.xz to /media/card"
sudo tar -C "$mnt" -xJf "${src}/${IMAGE}-image-${MACHINE}.rootfs.tar.xz"

echo "Generating a random-seed for urandom"
mkdir -p "${mnt}/var/lib/systemd"
sudo dd status=none if=/dev/urandom of="${mnt}/var/lib/systemd/random-seed" bs=512 count=1
sudo chmod 600 "${mnt}/var/lib/systemd/random-seed"

echo "Writing $target_hostname to ${mnt}/etc/hostname"
export mnt
export target_hostname
sudo -E bash -c 'echo $target_hostname > ${mnt}/etc/hostname'

echo "Unmounting $dev"
sudo umount "$dev"

echo "Done"
