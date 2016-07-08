SUMMARY = "Scripts to support an SD card O/S upgrade"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://init \
           file://default \
           file://manage_boot_flag_partition.sh \
           file://sysupgrade.sh \
           file://sysrevert.sh \
          "

PR = "r0"

S = "${WORKDIR}"

inherit update-rc.d

INITSCRIPT_NAME = "bootpart-flags"
INITSCRIPT_PARAMS = "start 99 5 ."

do_install_append () {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 init ${D}${sysconfdir}/init.d/bootpart-flags

    install -d ${D}${sysconfdir}/default
    install -m 0644 default ${D}${sysconfdir}/default/bootpart-flags

    install -d ${D}${bindir}
    install -m 0755 manage_boot_flag_partition.sh ${D}${bindir}
    install -m 0755 sysupgrade.sh ${D}${bindir}
    install -m 0755 sysrevert.sh ${D}${bindir}
}

FILES_${PN} = "${sysconfdir} ${bindir}"

RDEPENDS_${PN} = "coreutils dosfstools e2fsprogs-mke2fs util-linux" 
