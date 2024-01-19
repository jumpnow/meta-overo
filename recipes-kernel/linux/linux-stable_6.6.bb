require linux-stable.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

KERNEL_CONFIG_COMMAND = "oe_runmake_call -C ${S} CC="${KERNEL_CC}" O=${B} olddefconfig"

COMPATIBLE_MACHINE = "overo"

KERNEL_DEVICETREE = "\
    ti/omap/omap3-overo-chestnut43.dtb \
    ti/omap/omap3-overo-storm-chestnut43.dtb \
    ti/omap/omap3-overo-palo43.dtb \
    ti/omap/omap3-overo-storm-palo43.dtb \
    ti/omap/omap3-overo-storm-tobi.dtb \
    ti/omap/omap3-overo-tobi.dtb \
"

LINUX_VERSION = "6.6"

FILESEXTRAPATHS:prepend := "${THISDIR}/linux-stable-${LINUX_VERSION}:"

S = "${WORKDIR}/git"

PV = "6.6.12"
SRCREV = "47345b4264bc394a8d16bb16e8e7744965fa3934"
SRC_URI = " \
    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git;branch=linux-${LINUX_VERSION}.y \
    file://defconfig \
"
