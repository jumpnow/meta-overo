FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
    file://99-bluetooth-via-uart.rules \
    file://bluetooth-ttyO1-csr.sh \
    file://bluetooth-ttyO1-wilink.sh \
 "

do_install_append() {
    install -d ${D}${bindir}
    install -m 755 ${WORKDIR}/bluetooth-ttyO1-*.sh ${D}${bindir}

    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/99-bluetooth-via-uart.rules ${D}${sysconfdir}/udev/rules.d
}

FILES_${PN} += "${bindir} ${sysconfdir}"
