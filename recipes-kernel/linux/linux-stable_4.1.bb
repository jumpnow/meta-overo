require recipes-kernel/linux/linux-yocto.inc

KERNEL_IMAGETYPE = "zImage"

COMPATIBLE_MACHINE = "overo"

RDEPENDS_kernel-base += "kernel-devicetree"

KERNEL_DEVICETREE = " \
    omap3-overo-storm-tobi.dtb \
    omap3-overo-storm-tobi-pwm.dtb \
 "

LINUX_VERSION = "4.1"
LINUX_VERSION_EXTENSION = "-jumpnow"

FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable-4.1:"

S = "${WORKDIR}/git"

PR = "r1"

# v4.1.26
SRCREV = "888172862fa78505c4e4674c205a06586443d83f"
SRC_URI = " \
    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git;branch=linux-4.1.y \
    file://defconfig \
    file://0001-overo-Enable-SDIO-interrupts-for-Wifi-interface.patch \
    file://0002-madc-Do-not-disable-vusb3v1-regulator.patch \
    file://0003-pwm-omap-dmtimer-Backported.patch \
    file://0004-dts-Add-pwm-examples.patch \
 "
