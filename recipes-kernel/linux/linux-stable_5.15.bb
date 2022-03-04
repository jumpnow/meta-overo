require linux-stable.inc

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

KERNEL_CONFIG_COMMAND = "oe_runmake_call -C ${S} CC="${KERNEL_CC}" O=${B} olddefconfig"

COMPATIBLE_MACHINE = "overo"

KERNEL_DEVICETREE = "\
    omap3-overo-storm-tobi.dtb \
    omap3-overo-tobi.dtb \
"

LINUX_VERSION = "5.15"
LINUX_VERSION_EXTENSION = "-jumpnow"

FILESEXTRAPATHS:prepend := "${THISDIR}/linux-stable-${LINUX_VERSION}:"

S = "${WORKDIR}/git"

PV = "5.15.26"
SRCREV = "8993e6067f263765fd26edabf3e3012e3ec4d81e"
SRC_URI = " \
    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git;branch=linux-${LINUX_VERSION}.y \
    file://defconfig \
"
