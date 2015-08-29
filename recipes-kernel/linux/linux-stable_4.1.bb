require recipes-kernel/linux/linux-yocto.inc

KERNEL_IMAGETYPE = "zImage"

COMPATIBLE_MACHINE = "overo"

RDEPENDS_kernel-base += "kernel-devicetree"

KERNEL_DEVICETREE = " \
    omap3-overo-storm-tobi.dtb \
    omap3-overo-storm-tobiduo.dtb \
    omap3-overo-tobi.dtb \
    omap3-overo-tobiduo.dtb \
 "

LINUX_VERSION = "4.1"
LINUX_VERSION_EXTENSION = "-jumpnow"

FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable-4.1:"

S = "${WORKDIR}/git"

PR = "r3"

# v4.1.5
SRCREV = "352cb8677f83a6cf2139151578c8c79785d2d4bf"
SRC_URI = " \
    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git;branch=linux-4.1.y \
    file://0001-spidev-Add-generic-compatible-dt-id.patch \
    file://0002-omap3-dts-Add-DTS-for-Gumstix-TobiDuo-expansion-boar.patch \
    file://defconfig \
 "

