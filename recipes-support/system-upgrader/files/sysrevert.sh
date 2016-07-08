#!/bin/sh

MOUNT_DIR=/mnt/bootflags
FLAGS_PARTITION=/dev/mmcblk0p5
ROOTFS_MOUNT_DIR=/mnt/upgrade

echo -e -n "Finding the current root partition : "

cat /proc/cmdline | grep -q mmcblk0p2

if [ $? -eq 0 ]; then
        CURRENT_ROOT=/dev/mmcblk0p2
	NEW_ROOT=/dev/mmcblk0p3
else
        cat /proc/cmdline | grep -q mmcblk0p3

        if [ $? -eq 0 ]; then
                CURRENT_ROOT=/dev/mmcblk0p3
		NEW_ROOT=/dev/mmcblk0p2
        else
		echo "FAIL"
                echo "Current root device is not mmcblk0p2 or mmcblk0p3"
                exit 1
        fi
fi

echo "Current rootfs : ${CURRENT_ROOT}"
echo "New rootfs : ${NEW_ROOT}"

echo -e -n "Checking if the new rootfs looks valid"

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

echo -e -n "Mounting new rootfs at ${ROOTFS_MOUNT_DIR} : "

mount ${NEW_ROOT} ${ROOTFS_MOUNT_DIR}

if [ $? -eq 1 ]; then
	echo "FAIL"
	echo "Failed to mount the new rootfs"
	exit 1
fi

echo "OK"

echo -e -n "Sanity checking new rootfs : "

CHECK_DIRS="/bin /boot /etc /home /lib /sbin /usr"

for d in $CHECK_DIRS; do
	if [ ! -d ${ROOTFS_MOUNT_DIR}$d ]; then
		echo "FAIL"
		echo "New rootfs is missing a $d directory"
		exit 1
	fi
done

echo "OK"

echo -e -n "Unmounting the new rootfs : "

umount ${NEW_ROOT}

if [ $? -eq 1 ]; then
	echo "FAIL"
	echo "Failed to unmount the new rootfs"
	exit 1
fi 

echo "OK"

echo -e -n "Checking there is a /dev/mmcblk0p5 partition : "

fdisk -l /dev/mmcblk0 | grep -q mmcblk0p5

if [ $? -eq 1 ]; then
        echo "FAIL"
        echo "There is no /dev/mmcblk0p5 partition"
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

echo -e -n "Mounting ${FLAGS_PARTITION} read-write on ${MOUNT_DIR} : "

mount -t vfat ${FLAGS_PARTITION} ${MOUNT_DIR} 

if [ $? -ne 0 ]; then
	echo "FAIL"
	echo "Failed to mount ${FLAGS_PARTITION} on ${MOUNT_DIR} as type vfat"
	exit 1
fi

echo "OK"

echo -e -n "Updating flags partition : "

if [ "${CURRENT_ROOT}" = "/dev/mmcblk0p2" ]; then
	rm -rf ${MOUNT_DIR}/two
	rm -rf ${MOUNT_DIR}/three
	touch ${MOUNT_DIR}/three
else
	rm -rf ${MOUNT_DIR}/two
	rm -rf ${MOUNT_DIR}/three
	touch ${MOUNT_DIR}/two
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

echo "Rootfs on next boot will be $NEW_ROOT"

