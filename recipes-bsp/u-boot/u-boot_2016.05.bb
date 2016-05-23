require u-boot.inc

FILESEXTRAPATHS_prepend := "${THISDIR}/u-boot-2016.05:"

PV = "2016.05"
PR = "r1"

COMPATIBLE_MACHINE = "overo"

UBOOT_LOCALVERSION = "-jumpnow"

# v2016.05
SRCREV = "aeaec0e682f45b9e0c62c522fafea353931f73ed"
SRC_URI = " \
    git://git.denx.de/u-boot.git;branch=master;protocol=git \
    file://0001-Shrink-MLO-so-it-fits-in-SRAM.patch \
 "

SPL_BINARY = "MLO"
