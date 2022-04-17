SUMMARY = "U-boot boot script for overo"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

COMPATIBLE_MACHINE = "overo"

inherit deploy nopackages

DEPENDS = "u-boot-mkimage-native"

SRC_URI = "file://boot.cmd"

do_compile() {
    mkimage -A arm -T script -C none -n "Boot script" -d "${WORKDIR}/boot.cmd" boot.scr
}

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 boot.scr ${DEPLOYDIR}/boot.scr
}

addtask deploy before do_build after do_compile
