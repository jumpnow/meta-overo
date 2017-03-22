SUMMARY = "Gumstix Overo bluetooth hciattach scripts for sysvinit systems"

LICENSE = "GPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

PR = "r0"

SRC_URI = " \
    file://99-bluetooth-via-uart.rules \
    file://bluetooth-ttyO1-csr.sh \
    file://bluetooth-ttyO1-wilink.sh \
 "

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 755 bluetooth-ttyO1-csr.sh ${D}${bindir}
    install -m 755 bluetooth-ttyO1-wilink.sh ${D}${bindir}

    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/99-bluetooth-via-uart.rules ${D}${sysconfdir}/udev/rules.d
}

FILES_${PN} += "${bindir} ${sysconfdir}"
