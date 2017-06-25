require recipes-kernel/linux/linux-yocto.inc

KERNEL_IMAGETYPE = "zImage"

COMPATIBLE_MACHINE = "overo"

RDEPENDS_kernel-base += "kernel-devicetree"

KERNEL_DEVICETREE = " \
    omap3-overo-storm-tobi.dtb \
    omap3-overo-tobi.dtb \
 "

LINUX_VERSION = "4.9"
LINUX_VERSION_EXTENSION = "-jumpnow"

FILESEXTRAPATHS_prepend := "${THISDIR}/linux-stable-4.9:"

S = "${WORKDIR}/git"

PR = "r1"

PV = "4.9.34"
SRCREV = "493ecd5cd73ed41e319fe39816c6d3638ef080ff"
SRC_URI = " \
    git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git;branch=linux-4.9.y \
    file://defconfig \
    file://0001-Revert-Bluetooth-btmrvl_sdio-fix-firmware-activation.patch \
    file://0002-btmrvl_sdio-Add-linefeeds-to-log-messages.patch \
    file://0003-phy-twl4030-usb-Do-not-disable-vusb3v1-regulator.patch \
    file://0004-dts-Add-overo-wifi-and-bt-driver-config.patch \
    file://0005-btmrvl-Avoid-unnecessary-initialization.patch \
    file://0006-mwifiex-Skip-unsupported-CHAN_REGION_CFG-cmd.patch \
    file://0007-mwifiex-Remove-unsupported-GTK_REKEY_OFFLOAD_CFG-cmd.patch \
"
