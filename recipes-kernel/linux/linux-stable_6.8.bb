require linux-stable.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

KERNEL_CONFIG_COMMAND = "oe_runmake_call -C ${S} CC="${KERNEL_CC}" O=${B} olddefconfig"

COMPATIBLE_MACHINE = "overo"

KERNEL_DEVICETREE = "\
    ti/omap/omap3-overo-storm-tobi.dtb \
    ti/omap/omap3-overo-tobi.dtb \
"

LINUX_VERSION = "6.8"

FILESEXTRAPATHS:prepend := "${THISDIR}/linux-stable-${LINUX_VERSION}:"

S = "${WORKDIR}/git"

PV = "6.8.10"
SRCREV = "a0c69a570e420e86c7569b8c052913213eef2b45"
SRC_URI = " \
    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git;branch=linux-${LINUX_VERSION}.y \
    file://defconfig \
"
