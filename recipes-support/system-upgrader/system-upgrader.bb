SUMMARY = "Scripts to support an SD card O/S upgrade"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://init \
           file://default \
           file://bootflag.sh \
           file://sysupgrade.sh \
           file://syskeep.sh \
           file://sysswitch.sh \
          "

PR = "r1"

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
    install -m 0755 bootflag.sh ${D}${bindir}
    install -m 0755 sysupgrade.sh ${D}${bindir}
    install -m 0755 syskeep.sh ${D}${bindir}
    install -m 0755 sysswitch.sh ${D}${bindir}
}

FILES_${PN} = "${sysconfdir} ${bindir}"

RDEPENDS_${PN} = "coreutils dosfstools e2fsprogs-mke2fs util-linux" 
