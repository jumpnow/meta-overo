setenv bootpart 0:2
setenv flagpart 0:5
setenv bootdir /boot
setenv mmcroot /dev/mmcblk0p2 ro
setenv mmcrootfstype ext4 rootwait
if test -e mmc ${flagpart} two; then
    if test -e mmc ${flagpart} two_ok; then
        setenv bootpart 0:3
        setenv mmcroot /dev/mmcblk0p3 ro
    elif test ! -e mmc ${flagpart} two_tried; then
        fatwrite mmc ${flagpart} ${loadaddr} two_tried 4;
        setenv bootpart 0:3
        setenv mmcroot /dev/mmcblk0p3 ro
    fi;
elif test -e mmc ${flagpart} one; then
    if test ! -e mmc ${flagpart} one_ok; then
        if test -e mmc ${flagpart} one_tried; then
            setenv bootpart 0:3
            setenv mmcroot /dev/mmcblk0p3 ro
        else
            fatwrite mmc ${flagpart} ${loadaddr} one_tried 4;
        fi;
    fi;
fi;
setenv fdtfile omap4-duovero-parlor.dtb
setenv bootargs console=${console} root=${mmcroot} rootfstype=${mmcrootfstype}
load mmc ${bootpart} ${fdtaddr} ${bootdir}/${fdtfile}
load mmc ${bootpart} ${loadaddr} ${bootdir}/zImage
bootz ${loadaddr} - ${fdtaddr}
