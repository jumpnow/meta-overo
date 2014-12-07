SUMMARY = "A development image with bluetooth tools"
HOMEPAGE = "http://www.jumpnowtek.com"
LICENSE = "MIT"

require console-image.bb

BLUETOOTH_TOOLS = " \
    bluez4 \
    bluez-hcidump \
 "

IMAGE_INSTALL += " \
    ${BLUETOOTH_TOOLS} \
 "

export IMAGE_BASENAME = "bluetooth-image"

