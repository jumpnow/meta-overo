#!/bin/sh

MOUNT_DIR=/mnt/bootflags
FLAGS_PARTITION=/dev/mmcblk0p5
ROOTFS_MOUNT_DIR=/mnt/upgrade

echo -e -n "Finding the current root partition : "

cat /proc/cmdline | grep -q mmcblk0p2

if [ $? -eq 0 ]; then
        CURRENT_ROOT=/dev/mmcblk0p2
else
        cat /proc/cmdline | grep -q mmcblk0p3

        if [ $? -eq 0 ]; then
                CURRENT_ROOT=/dev/mmcblk0p3
        else
		echo "FAIL"
                echo "Current root device is not mmcblk0p2 or mmcblk0p3"
                exit 1
        fi
fi

echo "OK"

echo "Current rootfs : ${CURRENT_ROOT}"

if [ ! -d ${ROOTFS_MOUNT_DIR} ]; then
	echo -e -n "Creating mount point to check new rootfs : "
	mkdir ${ROOTFS_MOUNT_DIR}

	if [ $? -eq 1 ]; then
		echo "FAIL"
		echo "Failed to create ${ROOTFS_MOUNT_DIR} as temporary mount point"
		exit 1
	fi

	echo "OK"
fi 

echo -e -n "Checking there is a ${FLAGS_PARTITION} partition : "

fdisk -l /dev/mmcblk0 | grep -q ${FLAGS_PARTITION}

if [ $? -eq 1 ]; then
        echo "FAIL"
        echo "There is no ${FLAGS_PARTIION} partition"
        exit 1
fi

echo "OK"

echo -e -n "Checking that ${FLAGS_PARTITION} is not in use : "

mount | grep -q ${FLAGS_PARTITION} 

if [ $? -eq 0 ]; then
        echo "FAIL"
        echo "${FLAGS_PARTITION} is already mounted"
        exit 1
fi

echo "OK"

echo -e -n "Checking if ${MOUNT_DIR} mount point exists : "

if [ ! -d ${MOUNT_DIR} ]; then
	echo "NO"

	echo -e -n "Attempting to create mount point ${MOUNT_DIR} : "

	mkdir ${MOUNT_DIR}

	if [ $? -eq 1 ]; then
		echo "FAIL"
		exit 1
	else
		echo "OK"
	fi
else
	echo "OK"

	echo -e -n "Checking that ${MOUNT_DIR} is not in use : "

	mount | grep -q ${MOUNT_DIR} 

	if [ $? -eq 0 ]; then
		echo "FAIL"
		echo "${MOUNT_DIR} is in use by another mounted filesystem"
		exit 1
	fi

	echo "OK"
fi

echo -e -n "Mounting ${FLAGS_PARTITION} on ${MOUNT_DIR} : "

mount -t vfat ${FLAGS_PARTITION} ${MOUNT_DIR} 

if [ $? -ne 0 ]; then
	echo "FAIL"
	echo "Failed to mount ${FLAGS_PARTITION} on ${MOUNT_DIR} as type vfat"
	exit 1
fi

echo "OK"

echo -e -n "Updating flags partition : "

if [ "${CURRENT_ROOT}" = "/dev/mmcblk0p2" ]; then
	rm -rf ${MOUNT_DIR}/two*
	rm -rf ${MOUNT_DIR}/three*
	touch ${MOUNT_DIR}/two
else
	rm -rf ${MOUNT_DIR}/two*
	rm -rf ${MOUNT_DIR}/three*
	touch ${MOUNT_DIR}/three
fi

echo "OK"

echo -e -n "Unmounting ${FLAGS_PARTITION} : "

umount ${FLAGS_PARTITION} 

if [ $? -ne 0 ]; then
	echo "FAIL"
	echo "Failed to unmount ${FLAGS_PARTITION}"
	exit 1
fi

echo "OK"

echo "Rootfs on next boot will be $CURRENT_ROOT"
