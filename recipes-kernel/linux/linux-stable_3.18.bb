require recipes-kernel/linux/linux-yocto.inc

COMPATIBLE_MACHINE = "overo"

RDEPENDS_kernel-base += "kernel-devicetree"

KERNEL_DEVICETREE = " \
    omap3-overo-storm-tobi.dtb \
"

LINUX_VERSION = "3.18"
LINUX_VERSION_EXTENSION = "-jumpnow"

PR = "r1"

FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable-3.18:"

S = "${WORKDIR}/git"

# v3.18.37
SRCREV = "0ac0a856d986c1ab240753479f5e50fdfab82b14"
SRC_URI = " \
    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git;nocheckout=1;branch=linux-3.18.y \
    file://0001-dts-Enable-McBSP2-for-all-Overo-COMs.patch \
    file://0002-Enable-wilink8-wifi-chip.patch \
    file://0003-Enable-wilink8-bluetooth-chip.patch \
    file://0004-Enable-sdio-interrupts-for-wifi.patch \
    file://defconfig \
"

#    file://0003-Do-not-disable-vusb3v1-regulator.patch 
#    file://0005-pwm-omap-dmtimer-Backported.patch 

