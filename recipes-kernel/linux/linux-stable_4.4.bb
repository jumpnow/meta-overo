require recipes-kernel/linux/linux-yocto.inc

KERNEL_IMAGETYPE = "zImage"

COMPATIBLE_MACHINE = "overo"

RDEPENDS_kernel-base += "kernel-devicetree"

KERNEL_DEVICETREE = " \
    omap3-overo-storm-tobi.dtb \
    omap3-overo-tobi.dtb \
 "

LINUX_VERSION = "4.4"
LINUX_VERSION_EXTENSION = "-jumpnow"

FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable-4.4:"

S = "${WORKDIR}/git"

PR = "r1"

# v4.4.9
SRCREV = "1a1a512b983108015ced1e7a7c7775cfeec42d8c"
SRC_URI = " \
    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git;branch=linux-4.4.y \
    file://defconfig \
 "
