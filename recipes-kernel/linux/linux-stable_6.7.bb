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

LINUX_VERSION = "6.7"

FILESEXTRAPATHS:prepend := "${THISDIR}/linux-stable-${LINUX_VERSION}:"

S = "${WORKDIR}/git"

PV = "6.7.8"
SRCREV = "d6d6c49dbf4512f1421f5e42896e2d70dc121f9a"
SRC_URI = " \
    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git;branch=linux-${LINUX_VERSION}.y \
    file://defconfig \
"
