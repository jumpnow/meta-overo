DESCRIPTION = "JSON-C - A JSON implementation in C"
HOMEPAGE = "https://github.com/json-c/json-c/wiki"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRCREV = "d4e81f9ec8273914739808737fa0a27a3f0589fb"
SRC_URI = "git://github.com/json-c/json-c.git"

S = "${WORKDIR}/git"

inherit autotools

