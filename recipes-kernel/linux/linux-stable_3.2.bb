require recipes-kernel/linux/linux-yocto.inc

KERNEL_IMAGETYPE = "uImage"

COMPATIBLE_MACHINE = "overo"

LINUX_VERSION_EXTENSION = "-jumpnow"

FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable-3.2:"

PR = "r0"

S = "${WORKDIR}/git"

# v3.2.79
SRCREV = "161802562b8b7f546a4deafeb73f31f0afc7bd1e"
SRC_URI = " \
    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git;branch=linux-3.2.y \
    file://0001-mtd-nand-Eliminate-noisey-uncorrectable-error-messag.patch \
    file://0002-Fix-sprz319-erratum-2.1.patch \
    file://0003-drivers-net-smsc911x-return-ENODEV-if-device-is-not-.patch \
    file://0004-omap-mmc-twl4030-move-clock-input-selection-prior-to.patch \
    file://0005-Add-power-off-support-for-the-TWL4030-companion.patch \
    file://0006-omap-overo-Add-opp-init.patch \
    file://0007-omap-overo-only-enable-hardware-in-config.patch \
    file://0008-omap-add-cpufreq-support.patch \
    file://0009-ARM-OMAP3-hwmod-data-disable-multiblock-reads-on-MMC.patch \
    file://0010-ARM-OMAP3-hwmod-data-add-the-ES3-MMC-hwmods-to-the-3.patch \
    file://0011-omap-opp-test-for-iva-before-attempting-to-set-iva-o.patch \
    file://0012-omap-mmc-Adjust-dto-to-eliminate-timeout-errors.patch \
    file://0013-overo-do-not-overwrite-sdrc-setup-from-uboot.patch \
    file://0014-mmc-omap-add-sdio-interrupt-support.patch \
    file://0015-add-fgnu89-inline-option-for-gcc5.patch \
    file://defconfig \
 "
