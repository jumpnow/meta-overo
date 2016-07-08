#!/bin/bash

PART_SCRIPT="mk5parts.sh"

SUPPORT_SCRIPTS="copy_boot.sh copy_rootfs.sh ${PART_SCRIPT}"


if [ "x${1}" = "x" ]; then
        echo "Usage: ${0} <block device> <image> [<hostname>]"
        exit 1 
fi

if [ "${1}" = "sda" ]; then
	echo "Not going to work on /dev/sda"
	exit 1
fi

if [ ! -b "/dev/${1}" ]; then
	echo "Block device /dev/${1} not found"
	echo 1
fi

DEV=${1}

if [ "x${2}" = "x" ]; then
	echo "No image name provided"
	exit 1
fi

IMAGE="${2}"

if [ "x${3}" = "x" ]; then
	HOSTNAME=overo
else
	HOSTNAME="${3}"
fi

for script in $SUPPORT_SCRIPTS; do
	if [ ! -x ./$script ]; then
		echo "Support script not found: ./$script"
		exit 1
	fi
done

echo "Running partitioning script: ${PART_SCRIPT}"

sudo ./${PART_SCRIPT} ${DEV}

if [ $? -ne 0 ]; then
	echo "Script failed: sudo ./${PART_SCRIPT} ${DEV}" 
	exit 1
fi

./copy_boot.sh ${DEV}

if [ $? -ne 0 ]; then
	echo "Script failed: ./copy_boot.sh ${DEV}"
	exit 1
fi

./copy_rootfs.sh ${DEV} ${IMAGE} ${HOSTNAME}

if [ $? -ne 0 ]; then
	echo "Script failed: ./copy_rootfs.sh ${1} ${IMAGE} ${HOSTNAME}"
	exit 1
fi

if [ ${PART_SCRIPT} = "mk5parts.sh" ]; then
	echo "Formatting partition /dev/${DEV}5 as FAT"
	sudo mkfs.vfat -F 32 /dev/${1}5 -n FLAG

	if [ $? -ne 0 ]; then
		echo "Failed formatting /dev/${DEV}5"
		exit 1
	fi

	echo "Formatting partition /dev/${DEV}6 as ext4"
	sudo mkfs.ext4 -q -F /dev/${DEV}6

	if [ $? -ne 0 ]; then
		echo "Failed formatting /dev/${DEV}6"
		exit 1
	fi
fi
	
echo "Done"
