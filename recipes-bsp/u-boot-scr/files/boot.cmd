setenv bootpart 0:2
setenv bootdir /boot
setenv mmcroot /dev/mmcblk0p2 ro
setenv mmcrootfstype ext4 rootwait
setenv bootargs console=${console} root=${mmcroot} rootfstype=${mmcrootfstype}
setenv fdtfile omap3-overo-storm-tobi.dtb
load mmc ${bootpart} ${fdtaddr} ${bootdir}/${fdtfile}
load mmc ${bootpart} ${loadaddr} ${bootdir}/zImage
bootz ${loadaddr} - ${fdtaddr}
