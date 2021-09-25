UBOOT_SUFFIX = "img"
SPL_BINARY = "MLO"

UBOOT_LOCALVERSION = "-jumpnow"

require u-boot-common.inc
require u-boot.inc

DEPENDS += "bc-native dtc-native"
